"use client";
import React from "react";
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
import Link from "next/link";
import { Pen, Trash2 } from "lucide-react";
import { Input } from "@/components/ui/input";
import api from "@/utils/axiosInstance";
import Image from "next/image";

interface Category {
  _id: string;
  name: string;
}
interface Subcategory {
  _id: string;
  name: string;
}
interface Product {
  _id: string;
  name: string;
  shortDescription: string;
  categoryId: Category;
  subcategoryId: Subcategory;
  price: number;
  image: string;
  createdAt: string;
}

const Products = () => {
  const [formData, setFormData] = React.useState<Product[]>([]);
  const [loading, setLoading] = React.useState(false);
  const [searchTerm, setSearchTerm] = React.useState("");
  const [currentPage, setCurrentPage] = React.useState(1);
  const itemsPerPage = 8;

  const getAllProducts = async () => {
    setLoading(true);
    const res = await api.get("/api/v1/product/get-all-products");
    const data = res.data;
    setFormData(data.products);
    setLoading(false);
  };

  React.useEffect(() => {
    getAllProducts();
  }, []);

  const handleDeleteProduct = async (id: string) => {
    try {
      const res = await api.delete(`/api/v1/product/delete-product/${id}`);
      if (res.status === 200) {
        getAllProducts();
      }
    } catch (error: any) {
      alert(error.message);
    }
  };

  const filteredProducts = searchTerm
    ? formData.filter((product: Product) => {
        const lowerSearch = searchTerm.toLowerCase().trim();
        return (
          product?._id?.toString().toLowerCase().includes(lowerSearch) ||
          product?.name?.toLowerCase().includes(lowerSearch) ||
          product?.price?.toString().includes(lowerSearch) ||
          product?.categoryId?.name?.toLowerCase().includes(lowerSearch) ||
          product?.subcategoryId?.name?.toLowerCase().includes(lowerSearch)
        );
      })
    : formData;

  const totalPages = Math.ceil(filteredProducts.length / itemsPerPage);
  const startIndex = (currentPage - 1) * itemsPerPage;
  const currentProducts = filteredProducts.slice(
    startIndex,
    startIndex + itemsPerPage
  );

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
        <h1 className='font-bold text-2xl text-gray-800'>Products Lists</h1>
        <Link
          href={"/dashboard/products/create"}
          className='w-fit py-3 px-4 bg-gradient-to-r from-[#FE4F70] to-[#FFA387] cursor-pointer text-white rounded-full text-sm'
        >
          Add New Product
        </Link>
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
            onChange={(e) => {
              setSearchTerm(e.target.value);
              setCurrentPage(1);
            }}
          />
        </div>
        <TableWrapper>
          <TableCaption>A list of your recently created products.</TableCaption>
          <TableHeader className='!bg-[#fe4f70]/70 hover:!bg-[#fe4f70]'>
            <TableRow>
              <TableHead className='w-[100px]'>ID</TableHead>
              <TableHead>Image</TableHead>
              <TableHead>Name</TableHead>
              <TableHead>Category</TableHead>
              <TableHead>Subcategory</TableHead>
              <TableHead>Price (PKR)</TableHead>
              <TableHead>Created At</TableHead>
              <TableHead>Actions</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {currentProducts?.length > 0 ? (
              currentProducts.map((product: Product) => (
                <TableRow className='relative' key={product?._id}>
                  <TableCell>{product?._id.slice(0, 13)}...</TableCell>
                  <TableCell>
                    <Image
                      src={product?.image}
                      alt={`${product?.name}-image`}
                      width={50}
                      height={50}
                    />
                  </TableCell>
                  <TableCell>{product?.name}</TableCell>
                  <TableCell>{product?.categoryId?.name}</TableCell>
                  <TableCell>{product?.subcategoryId?.name}</TableCell>
                  <TableCell>{product?.price}</TableCell>
                  <TableCell>
                    {new Date(product?.createdAt).toLocaleDateString("en-US", {
                      year: "numeric",
                      month: "short",
                      day: "numeric",
                    })}
                  </TableCell>
                  <TableCell>
                    <div className='flex gap-x-2 items-center'>
                      <Link
                        href={`/dashboard/products/edit/${product?._id}`}
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
                              permanently delete the Product.
                            </AlertDialogDescription>
                          </AlertDialogHeader>
                          <AlertDialogFooter>
                            <AlertDialogCancel>Cancel</AlertDialogCancel>
                            <AlertDialogAction
                              onClick={() => handleDeleteProduct(product?._id)}
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
                <TableCell colSpan={8} className='text-center'>
                  No products found
                </TableCell>
              </TableRow>
            )}
          </TableBody>
        </TableWrapper>
      </div>
      <Pagination>
        <PaginationContent>
          <PaginationItem>
            <PaginationPrevious
              href='#'
              onClick={() => setCurrentPage((prev) => Math.max(prev - 1, 1))}
            />
          </PaginationItem>

          {[...Array(totalPages)].map((_, index) => (
            <PaginationItem key={index}>
              <PaginationLink
                href='#'
                isActive={currentPage === index + 1}
                onClick={() => setCurrentPage(index + 1)}
              >
                {index + 1}
              </PaginationLink>
            </PaginationItem>
          ))}

          {totalPages > 3 && <PaginationEllipsis />}

          <PaginationItem>
            <PaginationNext
              href='#'
              onClick={() =>
                setCurrentPage((prev) => Math.min(prev + 1, totalPages))
              }
            />
          </PaginationItem>
        </PaginationContent>
      </Pagination>
    </section>
  );
};

export default Products;
