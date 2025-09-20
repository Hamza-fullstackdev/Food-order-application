import axios from "axios";
import { store } from "../lib/store";
import { updateTokens, logoutUser } from "../lib/features/user/userSlice";
import { getCookie, setCookie, deleteCookie } from "cookies-next";

const api = axios.create({
  baseURL: process.env.NEXT_PUBLIC_BASE_URL,
});

api.interceptors.request.use(
  (config) => {
    const state = store.getState();
    let token = state.user.accessToken;
    if (!token) {
      token = getCookie("accessToken") as string;
    }
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => Promise.reject(error)
);

let isRefreshing = false;
let failedQueue: any[] = [];

const processQueue = (error: any, token: string | null = null) => {
  failedQueue.forEach((prom) => {
    if (error) {
      prom.reject(error);
    } else {
      prom.resolve(token);
    }
  });
  failedQueue = [];
};

api.interceptors.response.use(
  (response) => response,
  async (error) => {
    const originalRequest = error.config;
    const state = store.getState();
    const refreshToken = state.user.refreshToken;

    if (error.response?.status === 401 && !originalRequest._retry) {
      if (isRefreshing) {
        return new Promise(function (resolve, reject) {
          failedQueue.push({ resolve, reject });
        })
          .then((token) => {
            originalRequest.headers.Authorization = "Bearer " + token;
            return api(originalRequest);
          })
          .catch((err) => Promise.reject(err));
      }

      originalRequest._retry = true;
      isRefreshing = true;

      try {
        const res = await axios.post(
          `${process.env.NEXT_PUBLIC_BASE_URL}/api/v1/auth/refresh-token`,
          {},
          {
            headers: {
              Authorization: `Bearer ${refreshToken}`,
            },
          }
        );

        const { user } = res.data;
        const { accessToken, refreshToken: newRefreshToken } = user;

        store.dispatch(
          updateTokens({ accessToken, refreshToken: newRefreshToken })
        );
        setCookie("accessToken", accessToken, { maxAge: 60 * 15, path: "/" });
        setCookie("refreshToken", newRefreshToken, {
          maxAge: 60 * 60 * 24 * 7,
          path: "/",
        });

        console.log("Refreshed token successfully");
        api.defaults.headers.common["Authorization"] = "Bearer " + accessToken;
        processQueue(null, accessToken);

        return api(originalRequest);
      } catch (err: any) {
        processQueue(err, null);
        store.dispatch(logoutUser());
        deleteCookie("accessToken");
        deleteCookie("refreshToken");
        return Promise.reject(
          err.response?.data || {
            success: false,
            status: 500,
            message: "Failed to refresh token",
          }
        );
      } finally {
        isRefreshing = false;
      }
    }

    return Promise.reject(
      error.response?.data || {
        success: false,
        status: 500,
        message: "Something went wrong",
      }
    );
  }
);

export default api;
