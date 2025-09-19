"use client";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectGroup,
  SelectItem,
  SelectLabel,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import api from "@/utils/axiosInstance";
import Link from "next/link";
import { useRouter } from "next/navigation";
import React, { useEffect } from "react";
const AddSubcategory = () => {
  const [loading, setLoading] = React.useState(false);
  const [error, setError] = React.useState(false);
  const [errorMessage, setErrorMessage] = React.useState("");
  const [mainCategories, setMainCategories] = React.useState([]);
  const [formData, setFormData] = React.useState({
    name: "",
    categoryId: "",
  });
  const router = useRouter();

  interface Category {
    _id: string;
    name: string;
    createdAt: string;
  }
  const getCategories = async () => {
    try {
      const res = await api.get("/api/v1/category/get-all-categories");
      const data = res.data;
      setMainCategories(data.categories);
    } catch{
      setError(true);
      setErrorMessage("Something went wrong");
    }
  };
  useEffect(() => {
    getCategories();
  }, []);
  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };
  const handleFormData = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setLoading(true);
    try {
      const res = await api.post(
        "/api/v1/subcategory/add-subcategory",
        formData
      );
      const data = res.data;
      setLoading(false);
      if (res.status === 200) {
        router.push("/dashboard/sub-category");
      } else {
        setLoading(false);
        setError(true);
        setErrorMessage(data?.message);
      }
    } catch {
      setError(true);
      setLoading(false);
      setErrorMessage("Something went wrong");
    }
  };
  return (
    <section className='my-8'>
      <div className='flex items-center justify-between mb-6'>
        <div>
          <h1 className='font-bold text-2xl text-gray-800'>Add Subcategory</h1>
        </div>
        <div>
          <Link
            href={"/dashboard/sub-category"}
            className='w-fit py-3 px-4 bg-gradient-to-r from-[#FE4F70] to-[#FFA387] cursor-pointer text-white rounded-full text-sm'
          >
            Go Back
          </Link>
        </div>
      </div>
      <form onSubmit={handleFormData}>
        {error && (
          <div className='mb-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative'>
            <span className='block sm:inline text-sm'>{errorMessage}</span>
          </div>
        )}
        <div className='grid grid-cols-1 gap-4'>
          <div className='flex flex-col gap-2'>
            <Label htmlFor='category'>Category</Label>
            <Select
              name='categoryId'
              value={formData?.categoryId}
              onValueChange={(e) => setFormData({ ...formData, categoryId: e })}
            >
              <SelectTrigger className='w-full border border-black'>
                <SelectValue placeholder='Select main category' />
              </SelectTrigger>
              <SelectContent>
                <SelectGroup>
                  <SelectLabel>Main Categories</SelectLabel>
                  {mainCategories?.map((category: Category) => (
                    <SelectItem key={category?._id} value={category?._id}>
                      {category?.name}
                    </SelectItem>
                  ))}
                </SelectGroup>
              </SelectContent>
            </Select>
          </div>
          <div className='flex flex-col gap-2'>
            <Label htmlFor='name'>Sub-category name</Label>
            <Input
              type='text'
              id='name'
              name='name'
              placeholder='Enter Name'
              className='border border-black placeholder:text-black'
              required
              autoComplete='off'
              value={formData?.name}
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
            Create
          </button>
        </div>
      </form>
    </section>
  );
};

export default AddSubcategory;
