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
import {
  Pagination,
  PaginationContent,
  PaginationEllipsis,
  PaginationItem,
  PaginationLink,
  PaginationNext,
  PaginationPrevious,
} from "@/components/ui/pagination";
import { Pen, Trash2 } from "lucide-react";
import { Input } from "@/components/ui/input";
import Link from "next/link";
import React from "react";
import api from "@/utils/axiosInstance";

interface Category {
  _id: string;
  name: string;
  createdAt: string;
  updatedAt?: string;
  userId?: string;
}

interface Subcategory {
  _id: string;
  name: string;
  createdAt: string;
  updatedAt?: string;
  userId?: string;
  categoryId: Category;
}

const Subcategory = () => {
  const [formData, setFormData] = React.useState([]);
  const [loading, setLoading] = React.useState(false);
  const [searchTerm, setSearchTerm] = React.useState("");
  const [currentPage, setCurrentPage] = React.useState(1);
  const itemsPerPage = 8;

  const fetchData = async () => {
    try {
      setLoading(true);
      const subRes = await api.get("/api/v1/subcategory/get-all-subcategories");
      const subData = subRes.data;
      if (subData.status === 200) {
        setFormData(subData.subcategories);
      }
    } catch {
      alert("Something went wrong");
    } finally {
      setLoading(false);
    }
  };

  React.useEffect(() => {
    fetchData();
  }, []);

  const filteredCategory = searchTerm
    ? formData.filter((subcategory: Subcategory) => {
        const lowerSearch = searchTerm.toLowerCase().trim();
        const mainCategoryName =
          typeof subcategory.categoryId !== "string"
            ? subcategory.categoryId?.name?.toLowerCase()
            : undefined;

        return (
          subcategory?._id?.toString().toLowerCase().includes(lowerSearch) ||
          subcategory?.name?.toLowerCase().includes(lowerSearch) ||
          mainCategoryName?.includes(lowerSearch)
        );
      })
    : formData;

  const totalPages = Math.ceil(filteredCategory.length / itemsPerPage);
  const startIndex = (currentPage - 1) * itemsPerPage;
  const paginatedData = filteredCategory.slice(
    startIndex,
    startIndex + itemsPerPage
  );

  const handlePageChange = (page: number) => {
    if (page >= 1 && page <= totalPages) {
      setCurrentPage(page);
    }
  };
  const handleDeleteCategory = async (id: string) => {
    try {
      const res = await api.delete(
        `/api/v1/subcategory/delete-subcategory/${id}`
      );
      if (res.status === 200) {
        fetchData();
      }
    } catch {
      alert("Something went wrong");
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
          <h1 className='font-bold text-2xl text-gray-800'>
            Subcategories Lists
          </h1>
        </div>
        <div>
          <Link
            href={"/dashboard/sub-category/create"}
            className='w-fit py-3 px-4 bg-gradient-to-r from-[#d61355] to-[#ff0000] cursor-pointer text-white rounded-full text-sm'
          >
            Create new
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
            className='w-[300px] bg-transparent border border-[#d61355] focus-visible:ring-0'
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
          />
        </div>
        <TableWrapper>
          <TableCaption>
            A list of your recently created sub-categories.
          </TableCaption>
          <TableHeader className='!bg-[#d61355]/70 hover:!bg-[#d61355]'>
            <TableRow>
              <TableHead>ID</TableHead>
              <TableHead>Main Category</TableHead>
              <TableHead>Sub Category</TableHead>
              <TableHead>Created At</TableHead>
              <TableHead>Actions</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {paginatedData?.length > 0 ? (
              paginatedData.map((category: Subcategory) => (
                <TableRow key={category._id}>
                  <TableCell>{category._id.slice(0, 13)}...</TableCell>
                  <TableCell className='capitalize'>
                    {category.categoryId?.name}
                  </TableCell>
                  <TableCell className='capitalize'>{category.name}</TableCell>
                  <TableCell className='capitalize'>
                    {new Date(category.createdAt).toLocaleDateString("en-US", {
                      day: "numeric",
                      month: "short",
                      year: "numeric",
                    })}
                  </TableCell>
                  <TableCell>
                    <div className='flex gap-x-2 items-center'>
                      <Link
                        href={`/dashboard/sub-category/edit/${category._id}`}
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
                              permanently delete the sub category and remove all
                              of it data from our servers.
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
                <TableCell colSpan={5} className='text-center'>
                  No categories found
                </TableCell>
              </TableRow>
            )}
          </TableBody>
        </TableWrapper>
      </div>
      {totalPages > 1 && (
        <Pagination>
          <PaginationContent>
            <PaginationItem>
              <PaginationPrevious
                href='#'
                onClick={() => handlePageChange(currentPage - 1)}
              />
            </PaginationItem>

            {Array.from({ length: totalPages }, (_, index) => (
              <PaginationItem key={index}>
                <PaginationLink
                  href='#'
                  isActive={currentPage === index + 1}
                  onClick={() => handlePageChange(index + 1)}
                >
                  {index + 1}
                </PaginationLink>
              </PaginationItem>
            ))}

            <PaginationItem>
              <PaginationNext
                href='#'
                onClick={() => handlePageChange(currentPage + 1)}
              />
            </PaginationItem>
          </PaginationContent>
        </Pagination>
      )}
    </section>
  );
};

export default Subcategory;
