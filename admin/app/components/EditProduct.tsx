"use client";
import Link from "next/link";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useParams, useRouter } from "next/navigation";
import React from "react";
import api from "@/utils/axiosInstance";
import {
  Select,
  SelectContent,
  SelectGroup,
  SelectItem,
  SelectLabel,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Textarea } from "@/components/ui/textarea";

interface Category {
  _id: string;
  name: string;
  createdAt: string;
}
const EditProduct = () => {
  const [loading, setLoading] = React.useState(false);
  const [error, setError] = React.useState(false);
  const [errorMessage, setErrorMessage] = React.useState("");
  const [mainCategories, setMainCategories] = React.useState([]);
  const [subCategories, setSubCategories] = React.useState([]);
  const [formData, setFormData] = React.useState({
    name: "",
    categoryId: "",
    subcategoryId: "",
    description: "",
    shortDescription: "",
    price: "",
    image: null as File | null,
  });

  const router = useRouter();
  const params = useParams();

  const getProductById = async () => {
    setLoading(true);
    const res = await api.get(`/api/v1/product/get-product/${params.id}`);
    const data = res.data;
    setLoading(false);
    setFormData(data.product);
  };
  const getCategories = async () => {
    try {
      const res = await api.get("/api/v1/category/get-all-categories");
      const data = res.data;
      setMainCategories(data.categories);
    } catch {
      setError(true);
      setErrorMessage("Something went wrong");
    }
  };

  React.useEffect(() => {
    getProductById();
    getCategories();
  }, []);

  const handleChange = (
    e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>
  ) => {
    const { name, value } = e.target;
    setFormData((prev) => ({
      ...prev,
      [name]: value,
    }));
  };

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files && e.target.files[0]) {
      setFormData((prev) => ({
        ...prev,
        image: e.target.files![0],
      }));
    }
  };

  const handleChangeCategory = async (categoryId: string) => {
    setFormData((prev) => ({
      ...prev,
      categoryId: categoryId,
      subcategoryId: "",
    }));
    try {
      const res = await api.get(
        `/api/v1/subcategory/get-by-category/${categoryId}`
      );
      const data = res.data;
      setSubCategories(data.subcategories ?? []);
    } catch {
      setError(true);
      setErrorMessage("Something went wrong");
    }
  };

  const handleFormData = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setLoading(true);

    try {
      const fd = new FormData();
      fd.append("name", formData.name);
      fd.append("shortDescription", formData.shortDescription);
      fd.append("categoryId", formData.categoryId);
      fd.append("subcategoryId", formData.subcategoryId);
      fd.append("price", formData.price);
      fd.append("description", formData.description);
      if (formData.image) {
        fd.append("image", formData.image);
      }

      const res = await api.patch(
        `/api/v1/product/update-product/${params.id}`,
        fd,
        {
          headers: {
            "Content-Type": "multipart/form-data",
          },
        }
      );

      const data = res.data;
      setLoading(false);

      if (res.status === 200) {
        router.push("/dashboard/products");
      } else {
        setError(true);
        setErrorMessage(data.message);
      }
    } catch {
      setError(true);
      setErrorMessage("Something went wrong");
      setLoading(false);
    }
  };
  return (
    <section className='my-8'>
      <div className='flex items-center justify-between mb-6'>
        <div>
          <h1 className='font-bold text-2xl text-gray-800'>Edit Product</h1>
        </div>
        <div>
          <Link
            href={"/dashboard/products"}
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

        <div className='grid grid-cols-1 md:grid-cols-2 gap-4'>
          <div className='flex flex-col gap-2'>
            <Label htmlFor='name'>Name</Label>
            <Input
              type='text'
              id='name'
              name='name'
              placeholder='Enter Name'
              className='border border-black placeholder:text-black'
              autoComplete='off'
              value={formData.name}
              onChange={handleChange}
            />
          </div>

          <div className='flex flex-col gap-2'>
            <Label htmlFor='shortDescription'>Short Description</Label>
            <Input
              type='text'
              id='shortDescription'
              name='shortDescription'
              placeholder='Enter Short Description'
              className='border border-black placeholder:text-black'
              autoComplete='off'
              value={formData.shortDescription}
              onChange={handleChange}
            />
          </div>

          <div className='flex flex-col gap-2'>
            <Label htmlFor='categoryId'>Category</Label>
            <Select
              name='categoryId'
              value={formData?.categoryId}
              onValueChange={handleChangeCategory}
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
            <Label htmlFor='subcategoryId'>Subcategory</Label>
            <Select
              name='subcategoryId'
              value={formData?.subcategoryId}
              onValueChange={(e: string) =>
                setFormData({ ...formData, subcategoryId: e })
              }
            >
              <SelectTrigger className='w-full border border-black'>
                <SelectValue placeholder='Select Subcategory' />
              </SelectTrigger>
              <SelectContent>
                <SelectGroup>
                  <SelectLabel>Subcategories</SelectLabel>
                  {subCategories?.map((category: Category) => (
                    <SelectItem key={category?._id} value={category?._id}>
                      {category?.name}
                    </SelectItem>
                  ))}
                </SelectGroup>
              </SelectContent>
            </Select>
          </div>

          <div className='flex flex-col gap-2'>
            <Label htmlFor='price'>Price</Label>
            <Input
              type='number'
              id='price'
              name='price'
              placeholder='Enter Price'
              className='border border-black placeholder:text-black'
              autoComplete='off'
              value={formData.price}
              onChange={handleChange}
            />
          </div>

          <div className='flex flex-col gap-2'>
            <Label htmlFor='image'>Select Image</Label>
            <Input
              type='file'
              id='image'
              name='image'
              accept='image/*'
              onChange={handleFileChange}
            />
          </div>

          <div className='flex flex-col col-span-2 gap-2'>
            <Label htmlFor='description'>Description</Label>
            <Textarea
              id='description'
              name='description'
              placeholder='Enter Description'
              className='h-[200px] border border-black placeholder:text-black'
              autoComplete='off'
              value={formData.description}
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
            Update Product
          </button>
        </div>
      </form>
    </section>
  );
};

export default EditProduct;
