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
import { useParams, useRouter } from "next/navigation";
import React, { useEffect } from "react";
import Link from "next/link";
import api from "@/utils/axiosInstance";

interface Category {
  _id: string;
  name: string;
  createdAt: string;
}
const EditSubcategory = () => {
  const [loading, setLoading] = React.useState(false);
  const [error, setError] = React.useState(false);
  const [errorMessage, setErrorMessage] = React.useState("");
  const [mainCategories, setMainCategories] = React.useState([]);
  const [formData, setFormData] = React.useState({
    _id: "",
    name: "",
    categoryId: "",
  });
  const router = useRouter();
  const params = useParams();

  const getSubCategoryById = async () => {
    try {
      const res = await api.get(
        `/api/v1/subcategory/get-subcategory/${params.id}`
      );
      const data = res.data;
      setFormData({
        _id: data.subcategory._id,
        name: data.subcategory.name,
        categoryId:
          typeof data.subcategory.categoryId === "string"
            ? data.subcategory.categoryId
            : data.subcategory.categoryId._id,
      });
    } catch (error: any) {
      setError(true);
      setErrorMessage(error.message);
      setLoading(false);
    }
  };
  const getCategories = async () => {
    try {
      const res = await api.get("/api/v1/category/get-all-categories");
      const data = res.data;
      setMainCategories(data.categories);
    } catch (error: any) {
      setError(true);
      setErrorMessage(error.message);
      setLoading(false);
    }
  };
  useEffect(() => {
    getSubCategoryById();
    getCategories();
  }, []);
  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };
  const handleFormData = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setLoading(true);
    try {
      const res = await api.patch(
        `/api/v1/subcategory/update-subcategory/${params.id}`,
        formData
      );
      setLoading(false);
      if (res.status === 200) {
        router.push("/dashboard/sub-category");
      }
    } catch (error: any) {
      setError(true);
      setErrorMessage(error.message);
      setLoading(false);
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
          <h1 className='font-bold text-2xl text-gray-800'>Edit Subcategory</h1>
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
              name='category'
              value={formData?.categoryId}
              onValueChange={(e) => setFormData({ ...formData, categoryId: e })}
            >
              <SelectTrigger className='w-full border border-black'>
                <SelectValue placeholder='Select main category' />
              </SelectTrigger>
              <SelectContent>
                <SelectGroup>
                  <SelectLabel>Main Categories</SelectLabel>
                  {mainCategories.map((category: Category) => (
                    <SelectItem key={category._id} value={category._id}>
                      {category.name}
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
              value={formData.name}
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
            Update Subcategory
          </button>
        </div>
      </form>
    </section>
  );
};

export default EditSubcategory;
