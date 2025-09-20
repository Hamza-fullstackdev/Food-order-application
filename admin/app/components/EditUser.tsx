"use client";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import api from "@/utils/axiosInstance";
import Link from "next/link";
import { useParams, useRouter } from "next/navigation";
import React, { useEffect } from "react";

const EditUser = () => {
  const [loading, setLoading] = React.useState(false);
  const [error, setError] = React.useState(false);
  const [errorMessage, setErrorMessage] = React.useState("");
  const params = useParams();
  const router = useRouter();

  const [formData, setFormData] = React.useState<any>({
    _id: "",
    name: "",
    email: "",
    password: "",
    phoneNumber: "",
    isAdmin: false,
    image: null,
  });

  const getUserById = async () => {
    try {
      const res = await api.get(`/api/v1/user/get-user/${params.id}`);
      const data = res.data;
      setFormData({ ...data.response.user, image: null });
    } catch (error: any) {
      setError(true);
      setErrorMessage(error.message);
      setLoading(false);
    }
  };

  useEffect(() => {
    getUserById();
  }, []);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.type === "file") {
      setFormData({
        ...formData,
        [e.target.name]: e.target.files?.[0] || null,
      });
    } else {
      setFormData({ ...formData, [e.target.name]: e.target.value });
    }
  };

  const handleFormData = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setLoading(true);

    try {
      const fd = new FormData();
      fd.append("name", formData.name);
      fd.append("email", formData.email);
      if (formData.password) fd.append("password", formData.password);
      fd.append("phoneNumber", formData.phoneNumber);
      fd.append("isAdmin", String(formData.isAdmin));
      if (formData.image) {
        fd.append("profileImage", formData.image);
      }

      const res = await api.patch(`/api/v1/user/update-user/${params.id}`, fd, {
        headers: { "Content-Type": "multipart/form-data" },
      });

      setLoading(false);
      if (res.status === 200) {
        router.push("/dashboard/users");
      }
    } catch (error: any) {
      setError(true);
      setErrorMessage(error.message);
      setLoading(false);
    }
  };

  return (
    <section className='my-8'>
      <div className='flex items-center justify-between mb-6'>
        <h1 className='font-bold text-2xl text-gray-800'>Update User</h1>
        <Link
          href={"/dashboard/users"}
          className='w-fit py-3 px-4 bg-gradient-to-r from-[#FE4F70] to-[#FFA387] cursor-pointer text-white rounded-full text-sm'
        >
          Go Back
        </Link>
      </div>

      <form onSubmit={handleFormData} encType='multipart/form-data'>
        {error && (
          <div className='mb-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative'>
            <span className='block sm:inline text-sm'>{errorMessage}</span>
          </div>
        )}

        <div className='grid grid-cols-1 gap-4'>
          <div className='flex flex-col gap-2'>
            <Label htmlFor='name'>Name</Label>
            <Input
              type='text'
              id='name'
              name='name'
              placeholder='Enter Name'
              required
              value={formData?.name ?? ""}
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
              required
              value={formData?.email ?? ""}
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
              value={formData?.phoneNumber ?? ""}
              onChange={handleChange}
            />
          </div>

          <div className='flex flex-col gap-2'>
            <Label htmlFor='image'>Profile Image</Label>
            <Input
              type='file'
              id='image'
              name='image'
              accept='image/*'
              onChange={handleChange}
            />
          </div>

          <div className='flex flex-row gap-2'>
            <input
              type='checkbox'
              name='isAdmin'
              id='isAdmin'
              checked={formData?.isAdmin ?? false}
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
            {loading ? "Updating..." : "Update User"}
          </button>
        </div>
      </form>
    </section>
  );
};

export default EditUser;
