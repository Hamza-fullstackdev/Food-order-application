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
import Link from "next/link";
import { Pen, Trash2 } from "lucide-react";
import { Input } from "@/components/ui/input";
import api from "@/utils/axiosInstance";

interface User {
  _id: string;
  name: string;
  email: string;
  createdAt: string | Date;
}
const User = () => {
  const [formData, setFormData] = React.useState([]);
  const [loading, setLoading] = React.useState(false);
  const [searchTerm, setSearchTerm] = React.useState("");

  const getAllUsers = async () => {
    setLoading(true);
    const res = await api.get("/api/v1/user/get-all-users");
    const data = res.data;
    setLoading(false);
    setFormData(data.users);
  };
  React.useEffect(() => {
    getAllUsers();
  }, []);

  const handleDeleteUser = async (id: string) => {
    try {
      const res = await api.delete(`/api/v1/user/delete-user/${id}`);
      if (res.status === 200) {
        getAllUsers();
      }
    } catch {
      alert("Something went wrong");
    }
  };

  const filteredUsers = searchTerm
    ? formData.filter((user: User) => {
        const lowerSearch = searchTerm.toLowerCase().trim();
        return (
          user?._id?.toString().toLowerCase().includes(lowerSearch) ||
          user?.name?.toLowerCase().includes(lowerSearch) ||
          user?.email?.toLowerCase().includes(lowerSearch)
        );
      })
    : formData;
  return (
    <section className='my-8'>
      <div className='flex items-center justify-between mb-6'>
        <div>
          <h1 className='font-bold text-2xl text-gray-800'>Users Lists</h1>
        </div>
        <div>
          <Link
            href={"/dashboard/users/create"}
            className='w-fit py-3 px-4 bg-gradient-to-r from-[#FE4F70] to-[#FFA387] cursor-pointer text-white rounded-full text-sm'
          >
            Create Users
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
          <TableCaption>A list of your recently created users.</TableCaption>
          <TableHeader className='!bg-[#fe4f70]/70 hover:!bg-[#fe4f70]'>
            <TableRow>
              <TableHead className='w-[100px]'>ID</TableHead>
              <TableHead>Name</TableHead>
              <TableHead>Email</TableHead>
              <TableHead>Created At</TableHead>
              <TableHead>Actions</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {loading && (
              <TableRow>
                <TableCell colSpan={5} className='text-center'>
                  Loading...
                </TableCell>
              </TableRow>
            )}
            {filteredUsers?.length > 0 ? (
              filteredUsers.map((user: User) => (
                <TableRow className='relative' key={user._id}>
                  <TableCell>{user._id}</TableCell>
                  <TableCell>{user.name}</TableCell>
                  <TableCell>{user.email}</TableCell>
                  <TableCell>
                    {new Date(user.createdAt).toLocaleDateString("en-US", {
                      day: "numeric",
                      month: "short",
                      year: "numeric",
                    })}
                  </TableCell>
                  <TableCell>
                    <div className='flex gap-x-2 items-center'>
                      <Link
                        href={`/dashboard/users/edit/${user._id}`}
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
                              permanently delete the user account and remove all
                              of it data from our servers.
                            </AlertDialogDescription>
                          </AlertDialogHeader>
                          <AlertDialogFooter>
                            <AlertDialogCancel>Cancel</AlertDialogCancel>
                            <AlertDialogAction
                              onClick={() => handleDeleteUser(user._id)}
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
                  No users found
                </TableCell>
              </TableRow>
            )}
          </TableBody>
        </TableWrapper>
      </div>
    </section>
  );
};

export default User;
