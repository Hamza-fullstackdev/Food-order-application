import React from "react";
import { Folder, Inbox, Pen, Store, Tag, UserRoundPlus } from "lucide-react";

import {
  Sidebar as SidebarRoot,
  SidebarContent,
  SidebarGroup,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
  SidebarHeader,
} from "@/components/ui/sidebar";
import Link from "next/link";

const items = [
  {
    title: "Dashboard",
    url: "/dashboard",
    icon: Inbox,
  },
  {
    title: "Users",
    url: "/dashboard/users",
    icon: UserRoundPlus,
  },
  {
    title: "Categories",
    url: "/dashboard/category",
    icon: Folder,
  },
  {
    title: "Sub-categories",
    url: "/dashboard/sub-category",
    icon: Tag,
  },
  {
    title: "Products",
    url: "/dashboard/products",
    icon: Store,
  },
];
const Sidebar = () => {
  return (
    <SidebarRoot>
      <SidebarContent>
        <SidebarHeader>
          <SidebarMenu>
            <SidebarMenuItem>
              <SidebarMenuButton size='lg' asChild>
                <Link href='/admin' className='!text-white hover:!bg-white/10'>
                  <div className='flex aspect-square size-8 items-center justify-center rounded-sm border border-white text-sidebar-primary-foreground'>
                    <Pen className='size-4' />
                  </div>
                  <div className='flex flex-col gap-0.5 leading-none'>
                    <span className='font-semibold'>Food Order App</span>
                    <span className='text-xs'>Admin Panel</span>
                  </div>
                </Link>
              </SidebarMenuButton>
            </SidebarMenuItem>
          </SidebarMenu>
        </SidebarHeader>
        <SidebarGroup>
          <SidebarGroupLabel className='!text-white'>
            Application
          </SidebarGroupLabel>
          <SidebarGroupContent>
            <SidebarMenu>
              {items.map((item) => (
                <SidebarMenuItem key={item.title}>
                  <SidebarMenuButton asChild>
                    <Link
                      href={item.url}
                      className='!text-white hover:!bg-white/10'
                    >
                      <item.icon />
                      <span>{item.title}</span>
                    </Link>
                  </SidebarMenuButton>
                </SidebarMenuItem>
              ))}
            </SidebarMenu>
          </SidebarGroupContent>
        </SidebarGroup>
      </SidebarContent>
    </SidebarRoot>
  );
};

export default Sidebar;
