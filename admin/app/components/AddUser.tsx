"use client";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import api from "@/utils/axiosInstance";
import Image from "next/image";
import Link from "next/link";
import { useRouter } from "next/navigation";
import React from "react";

const AddUser = () => {
  const [loading, setLoading] = React.useState(false);
  const [error, setError] = React.useState(false);
  const [errorMessage, setErrorMessage] = React.useState("");
  const [profileImage, setProfileImage] = React.useState<File | null>(null);

  const [formData, setFormData] = React.useState({
    name: "",
    email: "",
    password: "",
    phoneNumber: "",
    isAdmin: false,
  });

  const router = useRouter();

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files && e.target.files[0]) {
      setProfileImage(e.target.files[0]);
    }
  };

  const handleFormData = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setLoading(true);

    try {
      const formDataToSend = new FormData();
      formDataToSend.append("name", formData.name);
      formDataToSend.append("email", formData.email);
      formDataToSend.append("password", formData.password);
      formDataToSend.append("phoneNumber", formData.phoneNumber);
      formDataToSend.append("isAdmin", String(formData.isAdmin));
      if (profileImage) {
        formDataToSend.append("profileImage", profileImage);
      }

      const res = await api.post("/api/v1/auth/register", formDataToSend, {
        headers: {
          "Content-Type": "multipart/form-data",
        },
      });

      setLoading(false);
      if (res.status === 201) {
        router.push("/dashboard/users");
      }
    } catch (error: any) {
      setError(true);
      setLoading(false);
      setErrorMessage(error.message);
    }
  };

  return (
    <section className='my-8'>
      {loading && (
        <div className='fixed inset-0 z-50 flex items-center justify-center animate-fadeIn'>
          <div className='absolute inset-0 bg-black/40'></div>
          <div className='relative z-10'>
            <div className='h-12 w-12 border-4 border-white/30 border-t-white rounded-full animate-spin'></div>
          </div>
        </div>
      )}
      <div className='flex items-center justify-between mb-6'>
        <div>
          <h1 className='font-bold text-2xl text-gray-800'>Create new Users</h1>
        </div>
        <div>
          <Link
            href={"/dashboard/users"}
            className='w-fit py-3 px-4 bg-gradient-to-r from-[#FE4F70] to-[#FFA387] cursor-pointer text-white rounded-full text-sm'
          >
            Go Back
          </Link>
        </div>
      </div>
      <form onSubmit={handleFormData} encType='multipart/form-data'>
        {error && (
          <div className='mb-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative'>
            <span className='block sm:inline text-sm'>{errorMessage}</span>
          </div>
        )}
        <div className='w-[180px] h-[180px] mx-auto relative'>
          <Image
            src={
              profileImage ? URL.createObjectURL(profileImage) : "/no-image.png"
            }
            fill
            alt='user'
            className='mx-auto rounded-full cursor-pointer object-cover'
          />
          <input
            type='file'
            name='profileImage'
            id='profileImage'
            className='absolute inset-0 opacity-0 cursor-pointer'
            onChange={handleFileChange}
          />
        </div>
        <div className='grid grid-cols-1 gap-4'>
          <div className='flex flex-col gap-2'>
            <Label htmlFor='name'>Name</Label>
            <Input
              type='text'
              id='name'
              name='name'
              placeholder='Enter Name'
              className='border border-black placeholder:text-black'
              required
              autoComplete='off'
              value={formData.name}
              onChange={handleChange}
            />
          </div>
          <div className='flex flex-col gap-2'>
            <Label htmlFor='email'>Email</Label>
            <Input
              type='email'
              id='email'
              name='email'
              placeholder='Enter Email'
              className='border border-black placeholder:text-black'
              required
              autoComplete='off'
              value={formData.email}
              onChange={handleChange}
            />
          </div>
          <div className='flex flex-col gap-2'>
            <Label htmlFor='password'>Password</Label>
            <Input
              type='password'
              id='password'
              name='password'
              placeholder='Enter Password'
              className='border border-black placeholder:text-black'
              required
              autoComplete='off'
              value={formData.password}
              onChange={handleChange}
            />
          </div>
          <div className='flex flex-col gap-2'>
            <Label htmlFor='phoneNumber'>Phone Number</Label>
            <Input
              type='number'
              id='phoneNumber'
              name='phoneNumber'
              placeholder='Enter Phone Number'
              className='border border-black placeholder:text-black'
              autoComplete='off'
              value={formData.phoneNumber}
              onChange={handleChange}
            />
          </div>
          <div className='flex flex-row gap-2'>
            <input
              type='checkbox'
              name='isAdmin'
              id='isAdmin'
              checked={formData.isAdmin}
              onChange={(e) =>
                setFormData({ ...formData, isAdmin: e.target.checked })
              }
            />
            <Label htmlFor='isAdmin'>Make Admin?</Label>
          </div>
        </div>
        <div className='mt-6'>
          <button
            type='submit'
            disabled={loading}
            className='w-full py-3 px-4 bg-gradient-to-r from-[#FE4F70] to-[#FFA387] cursor-pointer text-white rounded-full text-sm'
          >
            {loading ? "Creating..." : "Create"}
          </button>
        </div>
      </form>
    </section>
  );
};

export default AddUser;
