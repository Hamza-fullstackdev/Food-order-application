import { createSlice, PayloadAction } from "@reduxjs/toolkit";

interface UserState {
  _id: string | null;
  name: string;
  email: string;
  isAuthenticated: boolean;
  accessToken: string | null;
  refreshToken: string | null;
  createdAt: Date | null;
  updatedAt: Date | null;
}

const initialState: UserState = {
  _id: null,
  name: "",
  email: "",
  isAuthenticated: false,
  accessToken: null,
  refreshToken: null,
  createdAt: null,
  updatedAt: null,
};

const userSlice = createSlice({
  name: "user",
  initialState,
  reducers: {
    loginUser(
      state,
      action: PayloadAction<Omit<UserState, "isAuthenticated">>
    ) {
      return {
        ...state,
        ...action.payload,
        isAuthenticated: true,
      };
    },
    logoutUser() {
      return {
        ...initialState,
      };
    },
    deleteUser() {
      return {
        ...initialState,
      };
    },
    updateUser(
      state,
      action: PayloadAction<Partial<Omit<UserState, "isAuthenticated" | "_id">>>
    ) {
      return {
        ...state,
        ...action.payload,
      };
    },
  },
});

export const { loginUser, logoutUser, deleteUser, updateUser } =
  userSlice.actions;
export default userSlice.reducer;
