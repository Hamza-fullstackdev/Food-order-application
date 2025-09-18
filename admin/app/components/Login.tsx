"use client";
import { useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { loginUser } from "@/lib/features/user/userSlice";
import { Label } from "@/components/ui/label";
import { Input } from "@/components/ui/input";

const Login = () => {
  const [formData, setFormData] = useState({});
  const [error, setError] = useState(false);
  const dispatch = useDispatch();
  const [errorMessage, setErrorMessage] = useState("");
  const [loading, setLoading] = useState(false);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFormData({
      ...formData,
      [e.target.id]: e.target.value,
    });
  };
  const handleFormData = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setLoading(true);
    try {
      const res = await fetch(`${process.env.NEXT_PUBLIC_BASE_URL}/api/v1/auth/login`, {
        method: "POST",
        credentials: "include",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(formData),
      });
      const data = await res.json();
      setLoading(false);
      if (res.ok) {
        dispatch(loginUser(data.user));
        console.log(data);
      } else {
        console.log(data);
        setLoading(false);
        setError(true);
        setErrorMessage(data.message);
      }
    } catch (error) {
      setLoading(false);
      setError(true);
      setErrorMessage("Something went wrong");
    }
  };
  return (
    <div className='flex min-h-screen items-center justify-center p-4'>
      <div className='w-full max-w-md rounded-2xl p-6 shadow-sm dark:bg-gray-900 dark:border dark:border-gray-700'>
        <div className='my-4'>
          <div className='flex items-center justify-center'>
            <h1 className='text-2xl font-bold'>Login to Admin Panel</h1>
          </div>
          <div className='mt-2 flex items-center justify-center'>
            <svg width='33' height='6' xmlns='https://www.w3.org/2000/svg'>
              <defs>
                <linearGradient id='gradient' x1='0%' y1='0%' x2='100%' y2='0%'>
                  <stop offset='0%' stopColor='#FE4F70'></stop>
                  <stop offset='100%' stopColor='#FFA387'></stop>
                </linearGradient>
              </defs>
              <path
                d='M33 1c-3.3 0-3.3 4-6.598 4C23.1 5 23.1 1 19.8 1c-3.3 0-3.3 4-6.599 4-3.3 0-3.3-4-6.6-4S3.303 5 0 5'
                stroke='url(#gradient)'
                strokeWidth='2'
                fill='none'
              ></path>
            </svg>
          </div>
        </div>
        {error && (
          <div className='mb-3 flex items-center rounded-lg bg-red-200 p-4'>
            <span className='font-normal text-sm'>{errorMessage}</span>
          </div>
        )}
        <form className='space-y-4' onSubmit={handleFormData}>
          <div className='flex flex-col gap-2'>
            <Label htmlFor='email'>Email</Label>
            <Input
              id='email'
              type='email'
              autoComplete='on'
              placeholder='Enter your email'
              required
              onChange={handleChange}
            />
          </div>

          <div className='flex flex-col gap-2'>
            <Label htmlFor='password'>Password</Label>
            <Input
              id='password'
              type='password'
              placeholder='Enter your password'
              required
              autoComplete='on'
              onChange={handleChange}
            />
          </div>

          <button
            disabled={loading}
            type='submit'
            className='w-full from-[#FE4F70] to-[#FFA387] bg-gradient-to-r py-2 px-4 rounded-md text-white hover:bg-gradient-to-r hover:from-[#FE4F70] hover:to-[#FFA387] cursor-pointer disabled:bg-gray-400 disabled:cursor-not-allowed disabled:opacity-50'
          >
            Login
          </button>
        </form>
      </div>
    </div>
  );
};

export default Login;
