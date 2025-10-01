import jsPDF from "jspdf";
import autoTable from "jspdf-autotable";

declare module "jspdf" {
  interface jsPDF {
    lastAutoTable: {
      finalY: number;
    };
  }
}
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
export const generateInvoicePDF = async (order: Order) => {
  const doc = new jsPDF("p", "pt", "a4");
  const primary = "#fe4f70";
  const secondary = "#ffa387";

  // HEADER
  doc.setFillColor(primary);
  doc.rect(0, 0, doc.internal.pageSize.getWidth(), 60, "F");
  doc.setFontSize(18);
  doc.setTextColor("#fff");
  doc.text("Order Invoice", doc.internal.pageSize.getWidth() / 2, 40, {
    align: "center",
  });

  // ORDER ID + DATE
  doc.setFontSize(12);
  doc.setTextColor("#000");
  doc.text(`Order ID: ${order._id}`, 40, 90);
  doc.text(
    `Date: ${new Date(order.createdAt).toLocaleString()}`,
    doc.internal.pageSize.getWidth() - 200,
    90
  );

  let yPos = 120;

  // PRODUCTS (limit max 5)
  for (const [index, item] of order.items.slice(0, 5).entries()) {
    // Page-break check
    if (yPos > doc.internal.pageSize.getHeight() - 180) {
      doc.addPage();
      yPos = 80;
    }

    // Load product image
    try {
      const img = await loadImageAsBase64(item.productImage);
      const imgWidth = 80;
      const imgHeight = 80;
      const xCenter = doc.internal.pageSize.getWidth() / 2 - imgWidth / 2;

      doc.addImage(img, "JPEG", xCenter, yPos, imgWidth, imgHeight);
    } catch {
      doc.setFontSize(10);
      doc.setTextColor(primary);
      doc.text("Image not available", 40, yPos + 30);
    }

    yPos += 100;

    // Product Name
    doc.setFontSize(14);
    doc.setTextColor(primary);
    doc.text(item.productName, 40, yPos);

    yPos += 20;

    // Variants
    doc.setFontSize(10);
    doc.setTextColor("#000");
    item.selectedVariants.forEach((v) => {
      doc.text(`${v.groupName}: ${v.options.map((o) => o.name).join(", ")}`, 50, yPos);
      yPos += 15;
    });

    // Pricing
    doc.text(`Quantity: ${item.quantity}`, 50, yPos);
    yPos += 15;
    doc.text(`Unit Price: ${item.pricing.unitPrice}`, 50, yPos);
    yPos += 15;
    doc.text(`Line Total: ${item.pricing.lineTotal}`, 50, yPos);

    yPos += 30;

    // Divider
    doc.setDrawColor(secondary);
    doc.setLineWidth(0.5);
    doc.line(40, yPos, doc.internal.pageSize.getWidth() - 40, yPos);

    yPos += 20;
  }

  // SUMMARY TABLE
  const tableBody = [
    ["Subtotal", order.orderSummary.subtotal.toString()],
    ["Tax", order.orderSummary.tax.toString()],
    ["Delivery Fee", order.orderSummary.deliveryFee.toString()],
    ["Grand Total", order.orderSummary.grandTotal.toString()],
  ];

  autoTable(doc, {
    startY: yPos,
    body: tableBody,
    theme: "grid",
    styles: { fontSize: 11, halign: "right" },
    columnStyles: {
      0: { halign: "left", textColor: primary, fontStyle: "bold" },
      1: { halign: "right" },
    },
    margin: { left: 40, right: 40 },
  });

  // SAVE
  doc.save(`invoice-${order._id}.pdf`);
};

// Helper: image loader
async function loadImageAsBase64(url: string): Promise<string> {
  const response = await fetch(url);
  const blob = await response.blob();
  return new Promise<string>((resolve, reject) => {
    const reader = new FileReader();
    reader.onloadend = () => resolve(reader.result as string);
    reader.onerror = reject;
    reader.readAsDataURL(blob);
  });
}