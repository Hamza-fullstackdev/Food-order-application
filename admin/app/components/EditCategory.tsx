"use client";
import React, { useEffect, useState } from "react";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useParams, useRouter } from "next/navigation";
import Link from "next/link";
import api from "@/utils/axiosInstance";

const EditCategory = () => {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(false);
  const [errorMessage, setErrorMessage] = useState("");
  const router = useRouter();
  const params = useParams();
  const [formData, setFormData] = useState({
    _id: "",
    name: "",
    image: null as File | null,
  });

  const getCategoryById = async () => {
    setLoading(true);
    const res = await api.get(`/api/v1/category/get-category/${params.id}`);
    const data = res.data;
    setLoading(false);
    setFormData({
      _id: data.category._id,
      name: data.category.name,
      image: null,
    });
  };

  useEffect(() => {
    getCategoryById();
  }, []);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value, files } = e.target;
    if (files && files.length > 0) {
      setFormData({ ...formData, [name]: files[0] });
    } else {
      setFormData({ ...formData, [name]: value });
    }
  };

  const handleFormData = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setLoading(true);

    try {
      const fd = new FormData();
      fd.append("name", formData.name);
      if (formData.image) {
        fd.append("image", formData.image);
      }

      const res = await api.patch(
        `/api/v1/category/update-category/${params.id}`,
        fd,
        {
          headers: {
            "Content-Type": "multipart/form-data",
          },
        }
      );

      setLoading(false);
      if (res.status === 200) {
        router.push("/dashboard/category");
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
        <div>
          <h1 className='font-bold text-2xl text-gray-800'>Edit Category</h1>
        </div>
        <div>
          <Link
            href={"/dashboard/category"}
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
              accept='image/*'
              onChange={handleChange}
            />
          </div>
        </div>

        <div className='mt-6'>
          <button
            type='submit'
            disabled={loading}
            className='w-full py-3 px-4 bg-gradient-to-r from-[#FE4F70] to-[#FFA387] cursor-pointer text-white rounded-full text-sm'
          >
            {loading ? "Updating..." : "Update"}
          </button>
        </div>
      </form>
    </section>
  );
};

export default EditCategory;
