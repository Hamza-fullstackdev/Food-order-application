"use client";
import api from "@/utils/axiosInstance";
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
  Pagination,
  PaginationContent,
  PaginationItem,
  PaginationLink,
  PaginationNext,
  PaginationPrevious,
} from "@/components/ui/pagination";
import { Input } from "@/components/ui/input";

interface Log {
  _id: string;
  type: string;
  title: string;
  message: string;
  createdAt: string;
}

const Logs = () => {
  const [loading, setLoading] = React.useState(false);
  const [logs, setLogs] = React.useState<Log[]>([]);
  const [searchTerm, setSearchTerm] = React.useState("");
  const [currentPage, setCurrentPage] = React.useState(1);
  const logsPerPage = 8;

  const getAllLogs = async () => {
    setLoading(true);
    try {
      const res = await api.get("/api/v1/auth/get-logs");
      const data = res.data;
      setLogs(data.logs);
      setLoading(false);
    } catch {
      setLoading(false);
      alert("Something went wrong");
    }
  };

  React.useEffect(() => {
    getAllLogs();
  }, []);

  const filteredLogs = searchTerm
    ? logs.filter((log: Log) => {
        const lowerSearch = searchTerm.toLowerCase().trim();
        const createdAtString = new Date(log.createdAt)
          .toLocaleDateString("en-US", {
            month: "short",
            day: "numeric",
            year: "numeric",
          })
          .toLowerCase();

        return (
          log?.type?.toString().toLowerCase().includes(lowerSearch) ||
          log?.title?.toLowerCase().includes(lowerSearch) ||
          log?.message?.toLowerCase().includes(lowerSearch) ||
          createdAtString.includes(lowerSearch)
        );
      })
    : logs;

  const totalPages = Math.ceil(filteredLogs.length / logsPerPage);
  const indexOfLastLog = currentPage * logsPerPage;
  const indexOfFirstLog = indexOfLastLog - logsPerPage;
  const currentLogs = filteredLogs.slice(indexOfFirstLog, indexOfLastLog);

  const handlePageChange = (page: number) => {
    setCurrentPage(page);
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
          <h1 className='font-bold text-2xl text-gray-800'>System Logs</h1>
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
            onChange={(e) => {
              setSearchTerm(e.target.value);
              setCurrentPage(1);
            }}
          />
        </div>

        <TableWrapper>
          <TableHeader className='bg-gradient-to-r from-[#d61355] to-[#ff0000] hover:!from-[#d61355] hover:!to-[#ff0000]'>
            <TableRow>
              <TableHead className='!text-white'>Type</TableHead>
              <TableHead className='!text-white'>Title</TableHead>
              <TableHead className='!text-white'>Message</TableHead>
              <TableHead className='!text-white'>Date & Time</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {currentLogs.map((log) => (
              <TableRow key={log._id}>
                <TableCell className='capitalize'>{log.type}</TableCell>
                <TableCell className='capitalize'>{log.title}</TableCell>
                <TableCell>{log.message}</TableCell>
                <TableCell>
                  {new Date(log.createdAt).toLocaleDateString("en-US", {
                    month: "short",
                    day: "numeric",
                    year: "numeric",
                  })}{" "}
                  -{" "}
                  {new Date(log.createdAt).toLocaleTimeString("en-US", {
                    hour: "2-digit",
                    minute: "2-digit",
                    hour12: true,
                    second: "2-digit",
                  })}
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </TableWrapper>

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
      </div>
    </section>
  );
};

export default Logs;
