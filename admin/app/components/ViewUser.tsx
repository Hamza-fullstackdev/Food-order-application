"use client";
import api from "@/utils/axiosInstance";
import Image from "next/image";
import Link from "next/link";
import { useParams } from "next/navigation";
import React from "react";
import {
  Table as TableWrapper,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";

import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { Button } from "@/components/ui/button";
import { Bell } from "lucide-react";
import { ScrollArea } from "@/components/ui/scroll-area";

const ViewUser = () => {
  const [formData, setFormData] = React.useState<any>({});
  const [loading, setLoading] = React.useState(false);
  const [error, setError] = React.useState(false);
  const [errorMessage, setErrorMessage] = React.useState("");
  const params = useParams();

  const getUserById = async () => {
    try {
      setLoading(true);
      const res = await api.get(`/api/v1/user/get-user/${params.id}`);
      const data = res.data;
      setFormData(data.response);
      setLoading(false);
    } catch (error: any) {
      setError(true);
      setErrorMessage(error.message);
      setLoading(false);
    }
  };
  React.useEffect(() => {
    getUserById();
  }, []);
  return (
    <section className='my-8'>
      <div className='flex items-center justify-between mb-6'>
        <div>
          <h1 className='font-bold text-2xl text-gray-800 capitalize'>
            {formData?.user?.name} Profile
          </h1>
        </div>
        <div className='flex items-center gap-5'>
          <DropdownMenu>
            <DropdownMenuTrigger asChild>
              <Button variant='ghost' size='icon' className='relative'>
                <Bell className='h-6 w-6' />
                {formData?.notifications?.length > 0 && (
            <span className="absolute top-1 right-1 flex h-2 w-2">
              <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-red-500 opacity-75"></span>
              <span className="relative inline-flex rounded-full h-2 w-2 bg-red-600"></span>
            </span>
          )}
              </Button>
            </DropdownMenuTrigger>
            <DropdownMenuContent className='w-80'>
              <DropdownMenuLabel className="text-lg">Notifications</DropdownMenuLabel>
              <DropdownMenuSeparator />
              <ScrollArea className='max-h-[300px]'>
                <div className='p-1'>
                  {formData?.notifications?.length > 0 ? (
                    formData?.notifications?.map((notification: any) => (
                      <div
                        key={notification._id}
                        className='mb-2 rounded-md border p-2 hover:bg-accent transition'
                      >
                        <div className='flex justify-between gap-2'>
                          <div>
                            <p className='font-medium text-xs'>
                              {notification.title}
                            </p>
                            <p className='text-xs text-muted-foreground'>
                              {notification.message}
                            </p>
                          </div>
                          <div className='text-right'>
                            <p className='text-[10px] text-muted-foreground whitespace-nowrap'>
                              {new Date(
                                notification.createdAt
                              ).toLocaleDateString("en-US", {
                                day: "numeric",
                                month: "short",
                                year: "numeric",
                              })}
                            </p>
                            <p className='text-[10px] text-muted-foreground'>
                              {new Date(
                                notification.createdAt
                              ).toLocaleTimeString("en-US", {
                                hour: "2-digit",
                                minute: "2-digit",
                              })}
                            </p>
                          </div>
                        </div>
                      </div>
                    ))
                  ) : (
                    <p className='text-center text-sm text-muted-foreground py-2'>
                      No new notifications 🎉
                    </p>
                  )}
                </div>
              </ScrollArea>
            </DropdownMenuContent>
          </DropdownMenu>
          <Link
            href={"/dashboard/users"}
            className='w-fit py-3 px-4 bg-gradient-to-r from-[#d61355] to-[#ff0000] cursor-pointer text-white rounded-full text-sm'
          >
            Go Back
          </Link>
        </div>
      </div>
      {loading && (
        <div className='fixed inset-0 z-50 flex items-center justify-center animate-fadeIn'>
          <div className='absolute inset-0 bg-black/40'></div>
          <div className='relative z-10'>
            <div className='h-12 w-12 border-4 border-white/30 border-t-white rounded-full animate-spin'></div>
          </div>
        </div>
      )}
      {error && (
        <div className='p-4 mb-4 text-sm text-red-800 rounded-lg bg-red-50'>
          <div className='flex gap-3 items-center'>
            <svg
              xmlns='http://www.w3.org/2000/svg'
              className='stroke-current flex-shrink-0 h-6 w-6'
              fill='none'
              viewBox='0 0 24 24'
            >
              <path
                strokeLinecap='round'
                strokeLinejoin='round'
                strokeWidth='2'
                d='M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z'
              />
            </svg>
            <span>{errorMessage}</span>
          </div>
        </div>
      )}
      <div>
        <div className='grid grid-cols-1 md:grid-cols-3 gap-5'>
          <div className='relative border border-gray-200 p-4 rounded-lg'>
            <div>
              <div className='flex items-center justify-center'>
                <div className='w-[150px] h-[150px] relative'>
                  <Image
                    src={formData?.user?.profileImage || "/no-image.png"}
                    alt='user'
                    fill
                    className='rounded-full object-cover object-top'
                  />
                </div>
              </div>
            </div>
            <div>
              <span
                className={`${
                  formData?.isAdmin
                    ? "bg-green-100 text-green-500"
                    : "bg-yellow-100 text-yellow-500"
                } absolute top-1 left-2 text-xs px-2 py-1 rounded-sm mt-2`}
              >
                {formData?.user?.isAdmin ? "Admin" : "User"}
              </span>
            </div>
          </div>
          <div className='col-span-2'>
            <TableWrapper>
              <TableBody>
                <TableRow>
                  <TableCell>User Id</TableCell>
                  <TableCell>{formData?.user?._id}</TableCell>
                </TableRow>
                <TableRow>
                  <TableCell>Name</TableCell>
                  <TableCell>{formData?.user?.name}</TableCell>
                </TableRow>
                <TableRow>
                  <TableCell>Email</TableCell>
                  <TableCell>{formData?.user?.email}</TableCell>
                </TableRow>
                <TableRow>
                  <TableCell>Phone Number</TableCell>
                  <TableCell>{formData?.user?.phoneNumber || "-"}</TableCell>
                </TableRow>
                <TableRow>
                  <TableCell>Account Created</TableCell>
                  <TableCell>
                    {new Date(formData?.user?.createdAt).toLocaleDateString(
                      "en-US",
                      {
                        year: "numeric",
                        month: "long",
                        day: "numeric",
                      }
                    )}
                  </TableCell>
                </TableRow>
              </TableBody>
            </TableWrapper>
          </div>
        </div>
        {formData?.user?.isAdmin && (
          <div>
            <h3 className='font-bold text-xl text-gray-800 mt-8'>Categories</h3>
            <div className='mt-3'>
              <TableWrapper>
                <TableHeader>
                  <TableRow>
                    <TableHead>Image</TableHead>
                    <TableHead>Name</TableHead>
                    <TableHead>Creation Date</TableHead>
                    <TableHead>Creation Time</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {(formData?.categories?.length > 0 &&
                    formData?.categories?.map((category: any) => (
                      <TableRow key={category?._id}>
                        <TableCell>
                          <Image
                            src={category?.image || "/no-image.png"}
                            alt='category'
                            width={50}
                            height={50}
                          />
                        </TableCell>
                        <TableCell
                          className='capitalize'
                          title={category?.name}
                        >
                          {category?.name}
                        </TableCell>
                        <TableCell title={category?.createdAt}>
                          {new Date(category?.createdAt).toLocaleDateString(
                            "en-US",
                            { year: "numeric", month: "short", day: "numeric" }
                          )}
                        </TableCell>
                        <TableCell title={category?.createdAt}>
                          {new Date(category?.createdAt).toLocaleTimeString(
                            "en-US",
                            {
                              hour: "2-digit",
                              minute: "numeric",
                              hour12: true,
                            }
                          )}
                        </TableCell>
                      </TableRow>
                    ))) || (
                    <TableRow>
                      <TableCell colSpan={4} className='text-center'>
                        No categories created by this user
                      </TableCell>
                    </TableRow>
                  )}
                </TableBody>
              </TableWrapper>
            </div>
          </div>
        )}
        {formData?.user?.isAdmin && (
          <div>
            <h3 className='font-bold text-xl text-gray-800 mt-8'>
              Subcategories
            </h3>
            <div className='mt-3'>
              <TableWrapper>
                <TableHeader>
                  <TableRow>
                    <TableHead>Category</TableHead>
                    <TableHead>Subcategory</TableHead>
                    <TableHead>Creation Date</TableHead>
                    <TableHead>Creation Time</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {(formData?.subcategories?.length > 0 &&
                    formData?.subcategories?.map((category: any) => (
                      <TableRow key={category?._id}>
                        <TableCell
                          className='capitalize'
                          title={category?.categoryId?.name}
                        >
                          {category?.categoryId?.name}
                        </TableCell>
                        <TableCell
                          className='capitalize'
                          title={category?.name}
                        >
                          {category?.name}
                        </TableCell>
                        <TableCell title={category?.createdAt}>
                          {new Date(category?.createdAt).toLocaleDateString(
                            "en-US",
                            { year: "numeric", month: "short", day: "numeric" }
                          )}
                        </TableCell>
                        <TableCell title={category?.createdAt}>
                          {new Date(category?.createdAt).toLocaleTimeString(
                            "en-US",
                            {
                              hour: "2-digit",
                              minute: "numeric",
                              hour12: true,
                            }
                          )}
                        </TableCell>
                      </TableRow>
                    ))) || (
                    <TableRow>
                      <TableCell colSpan={4} className='text-center'>
                        No Subcategories created by this user
                      </TableCell>
                    </TableRow>
                  )}
                </TableBody>
              </TableWrapper>
            </div>
          </div>
        )}
        {formData?.user?.isAdmin && (
          <div>
            <h3 className='font-bold text-xl text-gray-800 mt-8'>
              Added Products
            </h3>
            <div className='mt-3'>
              <TableWrapper>
                <TableHeader>
                  <TableRow>
                    <TableHead>Image</TableHead>
                    <TableHead>Name</TableHead>
                    <TableHead>Category</TableHead>
                    <TableHead>Subcategory</TableHead>
                    <TableHead>Creation Date</TableHead>
                    <TableHead>Creation Time</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {(formData?.products?.length > 0 &&
                    formData?.products?.map((product: any) => (
                      <TableRow key={product?._id}>
                        <TableCell>
                          <Image
                            src={product?.image || "/no-image.png"}
                            alt='product'
                            width={50}
                            height={50}
                          />
                        </TableCell>
                        <TableCell>{product?.name}</TableCell>
                        <TableCell
                          className='capitalize'
                          title={product?.categoryId?.name}
                        >
                          {product?.categoryId?.name}
                        </TableCell>
                        <TableCell className='capitalize' title={product?.name}>
                          {product?.name}
                        </TableCell>
                        <TableCell title={product?.createdAt}>
                          {new Date(product?.createdAt).toLocaleDateString(
                            "en-US",
                            { year: "numeric", month: "short", day: "numeric" }
                          )}
                        </TableCell>
                        <TableCell title={product?.createdAt}>
                          {new Date(product?.createdAt).toLocaleTimeString(
                            "en-US",
                            {
                              hour: "2-digit",
                              minute: "numeric",
                              hour12: true,
                            }
                          )}
                        </TableCell>
                      </TableRow>
                    ))) || (
                    <TableRow>
                      <TableCell colSpan={6} className='text-center'>
                        No products created by this user
                      </TableCell>
                    </TableRow>
                  )}
                </TableBody>
              </TableWrapper>
            </div>
          </div>
        )}
        <div>
          <h3 className='font-bold text-xl text-gray-800 mt-8'>Reviews</h3>
          <div className='mt-3'>
            <TableWrapper>
              <TableHeader>
                <TableRow>
                  <TableHead>Image</TableHead>
                  <TableHead>Name</TableHead>
                  <TableHead>Rating</TableHead>
                  <TableHead>Comment</TableHead>
                  <TableHead>Creation Date</TableHead>
                  <TableHead>Creation Time</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {(formData?.ratings?.length > 0 &&
                  formData?.ratings?.map((rating: any) => (
                    <TableRow key={rating?._id}>
                      <TableCell>
                        <Image
                          src={rating?.productId?.image || "/no-image.png"}
                          alt={rating?.productId?.name || "Product-img"}
                          width={50}
                          height={50}
                        />
                      </TableCell>
                      <TableCell
                        className='capitalize'
                        title={rating?.productId?.name}
                      >
                        {rating?.productId?.name}
                      </TableCell>
                      <TableCell className='capitalize' title={rating?.rating}>
                        {rating?.rating}
                      </TableCell>
                      <TableCell className='capitalize' title={rating?.comment}>
                        {rating?.comment.slice(0, 30)}
                      </TableCell>
                      <TableCell title={rating?.createdAt}>
                        {new Date(rating?.createdAt).toLocaleDateString(
                          "en-US",
                          {
                            year: "numeric",
                            month: "short",
                            day: "numeric",
                          }
                        )}
                      </TableCell>
                      <TableCell title={rating?.createdAt}>
                        {new Date(rating?.createdAt).toLocaleTimeString(
                          "en-US",
                          {
                            hour: "2-digit",
                            minute: "numeric",
                            hour12: true,
                          }
                        )}
                      </TableCell>
                    </TableRow>
                  ))) || (
                  <TableRow>
                    <TableCell colSpan={6} className='text-center'>
                      No Reviews found for this user
                    </TableCell>
                  </TableRow>
                )}
              </TableBody>
            </TableWrapper>
          </div>
        </div>
        <div>
          <h3 className='font-bold text-xl text-gray-800 mt-8'>
            Saved in Cart
          </h3>
          <div className='mt-3'>
            <TableWrapper>
              <TableHeader>
                <TableRow>
                  <TableHead>Image</TableHead>
                  <TableHead>Name</TableHead>
                  <TableHead>Price</TableHead>
                  <TableHead>Quantity</TableHead>
                  <TableHead>Creation Date</TableHead>
                  <TableHead>Creation Time</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {(formData?.cartItems?.length > 0 &&
                  formData?.cartItems?.map((cart: any) => (
                    <TableRow key={cart?._id}>
                      <TableCell>
                        <Image
                          src={cart?.productId?.image || "/no-image.png"}
                          alt={cart?.productId?.name || "Product-img"}
                          width={50}
                          height={50}
                        />
                      </TableCell>
                      <TableCell
                        className='capitalize'
                        title={cart?.productId?.name}
                      >
                        {cart?.productId?.name}
                      </TableCell>
                      <TableCell
                        className='capitalize'
                        title={cart?.productId?.price}
                      >
                        {cart?.productId?.price}
                      </TableCell>
                      <TableCell className='capitalize' title={cart?.quantity}>
                        {cart?.quantity}
                      </TableCell>
                      <TableCell title={cart?.createdAt}>
                        {new Date(cart?.createdAt).toLocaleDateString("en-US", {
                          year: "numeric",
                          month: "short",
                          day: "numeric",
                        })}
                      </TableCell>
                      <TableCell title={cart?.createdAt}>
                        {new Date(cart?.createdAt).toLocaleTimeString("en-US", {
                          hour: "2-digit",
                          minute: "numeric",
                          hour12: true,
                        })}
                      </TableCell>
                    </TableRow>
                  ))) || (
                  <TableRow>
                    <TableCell colSpan={6} className='text-center'>
                      No Saved in Cart found for this user
                    </TableCell>
                  </TableRow>
                )}
              </TableBody>
            </TableWrapper>
          </div>
        </div>
      </div>
    </section>
  );
};

export default ViewUser;
