"use client";
import Link from "next/link";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useRouter } from "next/navigation";
import React from "react";
import api from "@/utils/axiosInstance";

const AddCategory = () => {
  const [loading, setLoading] = React.useState(false);
  const [error, setError] = React.useState(false);
  const [errorMessage, setErrorMessage] = React.useState("");
  const [formData, setFormData] = React.useState({
    name: "",
  });
  const [image, setImage] = React.useState<File | null>(null);

  const router = useRouter();

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleImageChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files && e.target.files[0]) {
      setImage(e.target.files[0]);
    }
  };

  const handleFormData = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setLoading(true);

    try {
      const data = new FormData();
      data.append("name", formData.name);
      if (image) {
        data.append("image", image);
      }

      const res = await api.post("/api/v1/category/add-category", data, {
        headers: {
          "Content-Type": "multipart/form-data",
        },
      });

      setLoading(false);
      if (res.status === 200) {
        router.push("/dashboard/category");
      }
    } catch (error: any) {
      setError(true);
      setLoading(false);
      setErrorMessage(error.response?.data?.message || error.message);
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
        <h1 className='font-bold text-2xl text-gray-800'>Add Category</h1>
        <Link
          href={"/dashboard/category"}
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
            <Label htmlFor='name'>Category name</Label>
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
            <Label htmlFor='image'>Category Image</Label>
            <Input
              type='file'
              id='image'
              name='image'
              required
              accept='image/*'
              onChange={handleImageChange}
            />
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

export default AddCategory;
