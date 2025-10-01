import { SidebarProvider, SidebarTrigger } from "@/components/ui/sidebar";
import Sidebar from "@/app/components/Sidebar";

export default function Layout({ children }: { children: React.ReactNode }) {
  return (
    <SidebarProvider>
      <Sidebar />
      <main className='px-3 md:px-8 flex-1'>
        <SidebarTrigger className='md:hidden' />
        {children}
      </main>
    </SidebarProvider>
  );
}
