"use client";
import api from "@/utils/axiosInstance";
import React, { useEffect } from "react";
import { useSelector } from "react-redux";

const Dashboard = () => {
  const { name } = useSelector((state: any) => state.user);
  const [stats, setStats] = React.useState({
    users: 0,
    products: 0,
    category: 0,
    subcategory: 0,
  });
  const getStatistics = async () => {
    const res = await api.get("/api/v1/product/get-statistics");
    const data = res.data;
    setStats(data.data);
  };
  useEffect(() => {
    getStatistics();
  }, []);
  const statsData = [
    {
      title: "Total Users",
      value: stats.users,
    },
    {
      title: "Total Products",
      value: stats.products,
    },
    {
      title: "Total Categories",
      value: stats.category,
    },
    {
      title: "Total Subcategories",
      value: stats.subcategory,
    },
  ];
  return (
    <section className='my-8'>
      <div className='mb-6 text-center'>
        <h1 className='font-bold text-2xl text-gray-800 capitalize'>
          Welcome <span className='text-[#d61355]'>{name}!</span> to Dashboard
        </h1>
        <p className='mt-1 text-gray-600'>
          A full stack food ordering flutter app project by{" "}
          <span className='text-[#d61355]'>Hamza, Fiaz and Saadullah</span>.
        </p>
      </div>
      <div className='mt-8'>
        <h2 className='font-bold text-2xl text-gray-800'>Statistics</h2>
        <div className='mt-3 grid grid-cols-1 gap-5 md:grid-cols-2 lg:grid-cols-3'>
          {statsData.map((stat: any, index: number) => (
            <div
              key={index}
              className='bg-gradient-to-r from-[#d61355] to-[#ff0000] rounded'
            >
              <div className='text-center py-14'>
                <h2 className='text-xl font-semibold text-white'>
                  {stat.title}
                </h2>
                <h3 className='mt-3 text-lg text-white'>{stat.value}</h3>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};

export default Dashboard;
