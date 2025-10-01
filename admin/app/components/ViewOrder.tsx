"use client";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import {
  AlertDialog,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogHeader,
  AlertDialogTitle,
  AlertDialogTrigger,
} from "@/components/ui/alert-dialog";
import { Separator } from "@/components/ui/separator";
import api from "@/utils/axiosInstance";
import Image from "next/image";
import Link from "next/link";
import { useParams } from "next/navigation";
import React, { useEffect } from "react";
import { cn } from "@/lib/utils";
import { Button } from "@/components/ui/button";
import { generateInvoicePDF } from "@/lib/GeneratePdf";

export interface VariantOption {
  id: string;
  name: string;
  price: number;
  _id: string;
}

export interface VariantGroup {
  groupId: string;
  groupName: string;
  options: VariantOption[];
  _id: string;
}

export interface Pricing {
  basePrice: number;
  addonsTotal: number;
  unitPrice: number;
  lineTotal: number;
}

export interface OrderItem {
  productId: string;
  productName: string;
  productImage: string;
  quantity: number;
  selectedVariants: VariantGroup[];
  pricing: Pricing;
  _id: string;
}

export interface OrderSummary {
  subtotal: number;
  tax: number;
  deliveryFee: number;
  grandTotal: number;
}

export interface Payment {
  method: "COD" | "Card";
  transactionId: string | null;
  status: "pending" | "paid" | "failed" | "refunded";
}

export interface Order {
  _id: string;
  userId: string;
  items: OrderItem[];
  orderSummary: OrderSummary;
  status: string;
  payment: Payment;
  createdAt: string;
  updatedAt: string;
  __v: number;
}

export interface OrderResponse {
  message: string;
  order: Order;
}

const statuses = [
  {
    key: "pending",
    label: "Pending",
    color: "bg-yellow-500 hover:bg-yellow-600",
  },
  {
    key: "confirmed",
    label: "Confirmed",
    color: "bg-blue-500 hover:bg-blue-600",
  },
  {
    key: "shipped",
    label: "Shipped",
    color: "bg-purple-500 hover:bg-purple-600",
  },
  {
    key: "delivered",
    label: "Delivered",
    color: "bg-green-500 hover:bg-green-600",
  },
  {
    key: "cancelled",
    label: "Cancelled",
    color: "bg-red-500 hover:bg-red-600",
  },
];

const ViewOrder = () => {
  const [loading, setLoading] = React.useState(false);
  const [order, setOrder] = React.useState<Order>({
    _id: "",
    userId: "",
    items: [],
    orderSummary: {
      subtotal: 0,
      tax: 0,
      deliveryFee: 0,
      grandTotal: 0,
    },
    status: "",
    payment: {
      method: "COD",
      transactionId: null,
      status: "pending",
    },
    createdAt: "",
    updatedAt: "",
    __v: 0,
  });
  const param = useParams();

  const getSingleOrder = async () => {
    setLoading(true);
    const res = await api.get<OrderResponse>(
      `/api/v1/order/get-order/${param.id}`
    );
    const data = res.data;
    setOrder(data.order);
    setLoading(false);
  };
  useEffect(() => {
    getSingleOrder();
  }, []);

  const handleStatusChange = async (status: string) => {
    try {
      const res = await api.patch(`/api/v1/order/update-order/${param.id}`, {
        status,
      });
      if (res.status === 200) {
        getSingleOrder();
      }
    } catch (error) {
      console.error(error);
      alert("Something went wrong, please try again later");
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
        <h1 className='font-bold text-2xl text-gray-800'>Order Details</h1>
        <Link
          href={"/dashboard/orders"}
          className='w-fit py-3 px-4 bg-gradient-to-r from-[#FE4F70] to-[#FFA387] cursor-pointer text-white rounded-full text-sm'
        >
          Go Back
        </Link>
      </div>
      <div className='w-full md:max-w-4xl mx-auto space-y-6'>
        <Card className='shadow-lg border border-primary/20'>
          <CardHeader className='flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4'>
            <CardTitle className='text-xl font-bold text-primary break-all'>
              Order #{order._id}
            </CardTitle>
            <div className='flex gap-2'>
              <Badge
                variant='outline'
                className={cn(
                  "px-3 py-1 text-xs font-medium capitalize",
                  order.status === "pending"
                    ? "bg-yellow-100 text-yellow-700 border-yellow-300"
                    : order.status === "confirmed"
                    ? "bg-blue-100 text-blue-700 border-blue-300"
                    : order.status === "shipped"
                    ? "bg-purple-100 text-purple-700 border-purple-300"
                    : order.status === "delivered"
                    ? "bg-green-100 text-green-700 border-green-300"
                    : order.status === "cancelled"
                    ? "bg-red-100 text-red-700 border-red-300"
                    : ""
                )}
              >
                {order.status}
              </Badge>
              <div className='flex justify-center'>
                <AlertDialog>
                  <AlertDialogTrigger asChild>
                    <Button size={"sm"} variant='outline'>
                      Show Invoice
                    </Button>
                  </AlertDialogTrigger>
                  <AlertDialogContent className='max-w-[350px] p-5 rounded-xl'>
                    <AlertDialogHeader>
                      <AlertDialogTitle className='text-center text-lg font-bold'>
                        Invoice
                      </AlertDialogTitle>
                    </AlertDialogHeader>
                    <div className='space-y-4'>
                      <div className='text-center space-y-1'>
                        <p className='text-sm font-medium'>Order ID</p>
                        <p className='text-xs text-muted-foreground'>
                          {order._id}
                        </p>
                        <Badge
                          variant='outline'
                          className={cn(
                            "px-3 py-1 text-xs font-medium capitalize",
                            order.status === "pending"
                              ? "bg-yellow-100 text-yellow-700 border-yellow-300"
                              : order.status === "confirmed"
                              ? "bg-blue-100 text-blue-700 border-blue-300"
                              : order.status === "shipped"
                              ? "bg-purple-100 text-purple-700 border-purple-300"
                              : order.status === "delivered"
                              ? "bg-green-100 text-green-700 border-green-300"
                              : order.status === "cancelled"
                              ? "bg-red-100 text-red-700 border-red-300"
                              : ""
                          )}
                        >
                          {order.status}
                        </Badge>
                      </div>
                      <Separator />
                      <div className='space-y-4'>
                        {order.items.map((item) => (
                          <div key={item._id} className='flex gap-3'>
                            <div className='relative w-22 h-14 rounded-md overflow-hidden border'>
                              <Image
                                src={item.productImage}
                                alt={item.productName}
                                fill
                                className='object-cover'
                              />
                            </div>
                            <div className='flex-1'>
                              <p className='text-sm font-semibold'>
                                {item.productName}
                              </p>
                              <p className='text-xs text-muted-foreground'>
                                Qty: {item.quantity}
                              </p>
                              <div className='flex flex-wrap gap-1 mt-1'>
                                {item.selectedVariants.flatMap((vg) =>
                                  vg.options.map((opt) => (
                                    <Badge
                                      key={opt.id}
                                      variant='secondary'
                                      className='text-[10px]'
                                    >
                                      {opt.name} (+{opt.price})
                                    </Badge>
                                  ))
                                )}
                              </div>
                            </div>
                            <p className='text-sm font-semibold'>
                              {item.pricing.lineTotal} PKR
                            </p>
                          </div>
                        ))}
                      </div>
                      <Separator />
                      <div className='space-y-1 text-sm'>
                        <div className='flex justify-between'>
                          <span>Subtotal</span>
                          <span>{order.orderSummary.subtotal} PKR</span>
                        </div>
                        <div className='flex justify-between'>
                          <span>Delivery</span>
                          <span>{order.orderSummary.deliveryFee} PKR</span>
                        </div>
                        <div className='flex justify-between font-semibold text-primary'>
                          <span>Grand Total</span>
                          <span>{order.orderSummary.grandTotal} PKR</span>
                        </div>
                      </div>
                      <Separator />
                      <div className='text-sm space-y-1'>
                        <p>
                          <span className='font-medium'>Payment:</span>{" "}
                          {order.payment.method} ({order.payment.status})
                        </p>
                        <p className='text-xs text-muted-foreground'>
                          {new Date(order.createdAt).toLocaleString()}
                        </p>
                      </div>
                      <div className='pt-3 flex justify-center gap-2 items-center'>
                        <Button
                          variant='default'
                          size='sm'
                          onClick={() => generateInvoicePDF(order)}
                        >
                          Download Invoice (PDF)
                        </Button>
                        <AlertDialogCancel>Close</AlertDialogCancel>
                      </div>
                    </div>
                  </AlertDialogContent>
                </AlertDialog>
              </div>
            </div>
          </CardHeader>
          <CardContent className='space-y-2 text-sm text-muted-foreground'>
            <p className='capitalize'>
              <span className='font-semibold text-foreground'>Payment:</span>{" "}
              {order.payment.method} ({order.payment.status})
            </p>
            <p>
              <span className='font-semibold text-foreground'>Placed on:</span>{" "}
              {new Date(order.createdAt).toLocaleDateString("en-US", {
                day: "numeric",
                month: "long",
                year: "numeric",
              })}{" "}
              at{" "}
              {new Date(order.createdAt).toLocaleTimeString("en-US", {
                hour: "numeric",
                minute: "numeric",
              })}
            </p>
          </CardContent>
        </Card>
        <div className='grid gap-6'>
          {order.items.map((item: any) => (
            <Card key={item._id} className='overflow-hidden shadow-md'>
              <CardContent className='flex flex-col sm:flex-row gap-6 p-6'>
                <div className='relative w-full sm:w-52 h-40 flex-shrink-0 rounded-xl overflow-hidden border'>
                  <Image
                    src={item.productImage}
                    alt={item.productName}
                    fill
                    className='object-cover'
                  />
                </div>
                <div className='flex-1 space-y-3'>
                  <div className='flex justify-between items-start'>
                    <h3 className='text-lg font-semibold text-foreground'>
                      {item.productName}
                    </h3>
                    <span className='text-primary font-semibold'>
                      {item.pricing.lineTotal} PKR
                    </span>
                  </div>
                  <p className='text-sm text-muted-foreground'>
                    Quantity: {item.quantity}
                  </p>
                  <div className='space-y-2'>
                    {item.selectedVariants.map((vg: any) => (
                      <div key={vg.groupId}>
                        <p className='text-sm font-medium text-foreground'>
                          {vg.groupName}:
                        </p>
                        <div className='flex flex-wrap gap-2'>
                          {vg.options.map((opt: any) => (
                            <Badge
                              key={opt.id}
                              variant='secondary'
                              className='text-xs'
                            >
                              {opt.name} (+{opt.price} PKR)
                            </Badge>
                          ))}
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
        <Card className='shadow-lg border-t-4 border-[#fe4f70]'>
          <CardHeader>
            <CardTitle className='text-lg font-semibold text-primary'>
              Order Summary
            </CardTitle>
          </CardHeader>
          <CardContent className='space-y-2 text-sm'>
            <div className='flex justify-between'>
              <span>Subtotal</span>
              <span>{order.orderSummary.subtotal} PKR</span>
            </div>
            <div className='flex justify-between'>
              <span>Delivery Fee</span>
              <span>{order.orderSummary.deliveryFee} PKR</span>
            </div>
            <Separator />
            <div className='flex justify-between text-base font-semibold'>
              <span>Grand Total</span>
              <span>{order.orderSummary.grandTotal} PKR</span>
            </div>
          </CardContent>
        </Card>
      </div>
      <div className='mt-5 w-full flex flex-row flex-wrap justify-center gap-x-5 gap-y-3'>
        {statuses.map((s) => (
          <Button
            key={s.key}
            size='sm'
            disabled={loading}
            onClick={() => handleStatusChange(s.key)}
            className={cn(
              "text-white shadow-md transition font-medium cursor-pointer px-4 py-2",
              s.color
            )}
          >
            {s.label}
          </Button>
        ))}
      </div>
    </section>
  );
};

export default ViewOrder;
