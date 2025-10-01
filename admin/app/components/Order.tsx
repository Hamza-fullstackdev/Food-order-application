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
import { Eye, Pen, Trash2 } from "lucide-react";
import { Input } from "@/components/ui/input";
import api from "@/utils/axiosInstance";
import Image from "next/image";
import { Badge } from "@/components/ui/badge";
import { cn } from "@/lib/utils";

interface Items {
  productName: string;
  productImage: string;
  quantity: number;
}
interface Payment {
  method: string;
}
interface OrderSummary {
  grandTotal: number;
}
interface Order {
  _id: string;
  status: string;
  orderSummary: OrderSummary;
  items: Items[];
  payment: Payment;
  createdAt: string;
  updatedAt: string;
}
const Order = () => {
  const [formData, setFormData] = React.useState([]);
  const [loading, setLoading] = React.useState(false);
  const [searchTerm, setSearchTerm] = React.useState("");

  const getAllOrders = async () => {
    setLoading(true);
    const res = await api.get("/api/v1/order/get-all-orders");
    const data = res.data;
    setLoading(false);
    setFormData(data.orders);
  };
  React.useEffect(() => {
    getAllOrders();
  }, []);


  const filteredOrders = searchTerm
    ? formData.filter((order: Order) => {
        const lowerSearch = searchTerm.toLowerCase().trim();
        return (
          order?._id?.toString().toLowerCase().includes(lowerSearch) ||
          order?.items[0]?.productName?.toLowerCase().includes(lowerSearch) ||
          order?.payment?.method?.toLowerCase().includes(lowerSearch) ||
          order?.status?.toLowerCase().includes(lowerSearch)
        );
      })
    : formData;
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
          <h1 className='font-bold text-2xl text-gray-800'>Order Lists</h1>
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
          <TableCaption>A list of your recent orders.</TableCaption>
          <TableHeader className='!bg-[#fe4f70]/70 hover:!bg-[#fe4f70]'>
            <TableRow>
              <TableHead>Date</TableHead>
              <TableHead>Time</TableHead>
              <TableHead>Image</TableHead>
              <TableHead>Product</TableHead>
              <TableHead>Quantity</TableHead>
              <TableHead>Total</TableHead>
              <TableHead>Status</TableHead>
              <TableHead>Payment</TableHead>
              <TableHead>Actions</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {filteredOrders?.length > 0 ? (
              filteredOrders.map((order: Order) => (
                <TableRow className='relative' key={order._id}>
                  <TableCell>
                    {new Date(order.createdAt).toLocaleDateString("en-US", {
                      day: "numeric",
                      month: "short",
                      year: "numeric",
                    })}
                  </TableCell>
                  <TableCell>
                    {new Date(order.createdAt).toLocaleTimeString("en-US", {
                      hour: "2-digit",
                      minute: "numeric",
                      hour12: true,
                    })}
                  </TableCell>
                  <TableCell>
                    <div className='w-8 h-8 relative'>
                      <Image
                        src={order?.items[0]?.productImage || "/no-image.png"}
                        alt={order?.items[0]?.productName}
                        fill
                        className='rounded-full object-cover object-top'
                      />
                    </div>
                  </TableCell>
                  <TableCell className='capitalize'>
                    {order?.items[0]?.productName}
                  </TableCell>
                  <TableCell>{order?.items[0]?.quantity}</TableCell>
                  <TableCell>Rs {order?.orderSummary.grandTotal}</TableCell>
                  <TableCell className='capitalize'>
                    <Badge
                      variant='outline'
                      className={cn(
                        "px-3 py-1 text-xs font-medium capitalize",
                        order.status === "pending"
                          ? "bg-yellow-100 text-yellow-700 border-yellow-300"
                          : order.status === "completed"
                          ? "bg-green-100 text-green-700 border-green-300"
                          : "bg-red-100 text-red-700 border-red-300"
                      )}
                    >
                      {order.status}
                    </Badge>
                  </TableCell>
                  <TableCell className='capitalize'>
                    {order?.payment?.method}
                  </TableCell>
                  <TableCell>
                    <div className='flex gap-x-2 items-center'>
                      <Link
                        href={`/dashboard/orders/view/${order._id}`}
                        className='bg-blue-500 text-white px-2 py-2 rounded'
                      >
                        <Eye size={12} />
                      </Link>
                    </div>
                  </TableCell>
                </TableRow>
              ))
            ) : (
              <TableRow>
                <TableCell colSpan={9} className='text-center'>
                  No orders found
                </TableCell>
              </TableRow>
            )}
          </TableBody>
        </TableWrapper>
      </div>
    </section>
  );
};

export default Order;
