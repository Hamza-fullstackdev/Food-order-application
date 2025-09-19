"use client";
import {
  Table as TableWrapper,
  TableBody,
  TableCaption,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
  AlertDialogTrigger,
} from "@/components/ui/alert-dialog";
import { Pen, Trash2 } from "lucide-react";
import { Input } from "@/components/ui/input";
import Link from "next/link";
import React from "react";
import api from "@/utils/axiosInstance";

interface Category {
  _id: string;
  name: string;
  createdAt: string;
}
const Category = () => {
  const [formData, setFormData] = React.useState([]);
  const [loading, setLoading] = React.useState(false);
  const [searchTerm, setSearchTerm] = React.useState("");

  const getAllCategories = async () => {
    setLoading(true);
    const res = await api.get("/api/v1/category/get-all-categories");
    const data = res.data;
    setLoading(false);
    setFormData(data.categories);
  };
  React.useEffect(() => {
    getAllCategories();
  }, []);

  const filteredCategory = searchTerm
    ? formData.filter((category: Category) => {
        const lowerSearch = searchTerm.toLowerCase().trim();
        return (
          category?._id?.toString().toLowerCase().includes(lowerSearch) ||
          category?.name?.toLowerCase().includes(lowerSearch)
        );
      })
    : formData;
  const handleDeleteCategory = async (id: string) => {
    try {
      const res = await api.delete(`/api/v1/category/delete-category/${id}`);
      if (res.status === 200) {
        getAllCategories();
      }
    } catch {
      alert("Something went wrong");
    }
  };
  return (
    <section className='my-8'>
      <div className='flex items-center justify-between mb-6'>
        <div>
          <h1 className='font-bold text-2xl text-gray-800'>Category Lists</h1>
        </div>
        <div>
          <Link
            href={"/dashboard/category/create"}
            className='w-fit py-3 px-4 bg-gradient-to-r from-[#FE4F70] to-[#FFA387] cursor-pointer text-white rounded-full text-sm'
          >
            Create new Category
          </Link>
        </div>
      </div>
      <div>
        <div className='mb-2 flex items-end justify-end'>
          <Input
            type='search'
            id='search'
            name='search'
            placeholder='Start typing to search'
            className='w-[300px] bg-transparent border border-[#fe4f70] focus-visible:ring-0'
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
          />
        </div>
        <TableWrapper>
          <TableCaption>
            A list of your recently created categories.
          </TableCaption>
          <TableHeader className='!bg-[#fe4f70]/70 hover:!bg-[#fe4f70]'>
            <TableRow>
              <TableHead className='w-[100px]'>ID</TableHead>
              <TableHead>Category</TableHead>
              <TableHead>Date</TableHead>
              <TableHead>Time</TableHead>
              <TableHead>Actions</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {loading && (
              <TableRow>
                <TableCell colSpan={4} className='text-center'>
                  Loading...
                </TableCell>
              </TableRow>
            )}
            {filteredCategory?.length > 0 ? (
              filteredCategory.map((category: Category) => (
                <TableRow key={category._id}>
                  <TableCell>{category._id.slice(0, 13)}...</TableCell>
                  <TableCell className='capitalize'>{category.name}</TableCell>
                  <TableCell>
                    {new Date(category.createdAt).toLocaleDateString("en-US", {
                      year: "numeric",
                      month: "short",
                      day: "numeric",
                    })}
                  </TableCell>
                  <TableCell>
                    {new Date(category.createdAt).toLocaleTimeString("en-US", {
                      hour: "2-digit",
                      minute: "2-digit",
                    })}
                  </TableCell>
                  <TableCell>
                    <div className='flex gap-x-2 items-center'>
                      <Link
                        href={`/dashboard/category/edit/${category._id}`}
                        className='bg-green-500 text-white px-2 py-2 rounded'
                      >
                        <Pen size={12} />
                      </Link>
                      <AlertDialog>
                        <AlertDialogTrigger className='bg-red-500 text-white cursor-pointer px-2 py-2 rounded'>
                          <Trash2 size={12} />
                        </AlertDialogTrigger>
                        <AlertDialogContent>
                          <AlertDialogHeader>
                            <AlertDialogTitle>
                              Are you absolutely sure?
                            </AlertDialogTitle>
                            <AlertDialogDescription>
                              This action cannot be undone. This will
                              permanently delete the category and remove all of
                              it data from our servers.
                            </AlertDialogDescription>
                          </AlertDialogHeader>
                          <AlertDialogFooter>
                            <AlertDialogCancel>Cancel</AlertDialogCancel>
                            <AlertDialogAction
                              onClick={() => handleDeleteCategory(category._id)}
                            >
                              Continue
                            </AlertDialogAction>
                          </AlertDialogFooter>
                        </AlertDialogContent>
                      </AlertDialog>
                    </div>
                  </TableCell>
                </TableRow>
              ))
            ) : (
              <TableRow>
                <TableCell colSpan={4} className='text-center'>
                  No categories found
                </TableCell>
              </TableRow>
            )}
          </TableBody>
        </TableWrapper>
      </div>
    </section>
  );
};

export default Category;
