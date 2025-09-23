"use client";
import Link from "next/link";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useParams, useRouter } from "next/navigation";
import React from "react";
import api from "@/utils/axiosInstance";
import {
  Select,
  SelectContent,
  SelectGroup,
  SelectItem,
  SelectLabel,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Textarea } from "@/components/ui/textarea";
import { Button } from "@/components/ui/button";

interface Category {
  _id: string;
  name: string;
  createdAt: string;
}

interface VariantOption {
  name: string;
  price: string;
}

interface VariantGroup {
  name: string;
  isRequired: boolean;
  maxSelectable: number;
  options: VariantOption[];
}

const EditProduct = () => {
  const [loading, setLoading] = React.useState(false);
  const [error, setError] = React.useState(false);
  const [errorMessage, setErrorMessage] = React.useState("");
  const [mainCategories, setMainCategories] = React.useState<Category[]>([]);
  const [subCategories, setSubCategories] = React.useState<Category[]>([]);
  const [variantGroups, setVariantGroups] = React.useState<VariantGroup[]>([]);

  const [formData, setFormData] = React.useState({
    name: "",
    categoryId: "",
    subcategoryId: "",
    description: "",
    shortDescription: "",
    price: "",
    image: null as File | null,
  });

  const router = useRouter();
  const params = useParams();

  const getProductById = async () => {
    try {
      setLoading(true);
      const res = await api.get(`/api/v1/product/get-product/${params.id}`);
      const product = res.data.product;

      setFormData({
        name: product.name || "",
        categoryId: product.categoryId?._id || "",
        subcategoryId: product.subcategoryId?._id || "",
        description: product.description || "",
        shortDescription: product.shortDescription || "",
        price: product.price || "",
        image: null,
      });

      if (product.variantGroups) {
        setVariantGroups(product.variantGroups);
      }

      if (product.categoryId?._id) {
        await handleChangeCategory(product.categoryId._id, false);
      }

      setLoading(false);
    } catch (error: any) {
      setError(true);
      setErrorMessage(error.message);
      setLoading(false);
    }
  };

  const getCategories = async () => {
    try {
      const res = await api.get("/api/v1/category/get-all-categories");
      setMainCategories(res.data.categories);
    } catch (error: any) {
      setError(true);
      setErrorMessage(error.message);
    }
  };

  React.useEffect(() => {
    getProductById();
    getCategories();
  }, []);

  const handleChange = (
    e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>
  ) => {
    const { name, value } = e.target;
    setFormData((prev) => ({
      ...prev,
      [name]: value,
    }));
  };

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files && e.target.files[0]) {
      setFormData((prev) => ({
        ...prev,
        image: e.target.files![0],
      }));
    }
  };

  const handleChangeCategory = async (
    categoryId: string,
    resetSub = true
  ) => {
    setFormData((prev) => ({
      ...prev,
      categoryId: categoryId,
      subcategoryId: resetSub ? "" : prev.subcategoryId,
    }));
    try {
      const res = await api.get(
        `/api/v1/subcategory/get-by-category/${categoryId}`
      );
      setSubCategories(res.data.subcategories ?? []);
    } catch (error: any) {
      setError(true);
      setErrorMessage(error.message);
    }
  };

  const addVariantGroup = () => {
    setVariantGroups((prev) => [
      ...prev,
      { name: "", isRequired: true, maxSelectable: 1, options: [] },
    ]);
  };

  const removeVariantGroup = (index: number) => {
    setVariantGroups((prev) => prev.filter((_, i) => i !== index));
  };

  const handleVariantGroupChange = (
    index: number,
    field: keyof VariantGroup,
    value: any
  ) => {
    const newGroups = [...variantGroups];
    (newGroups[index] as any)[field] = value;
    setVariantGroups(newGroups);
  };

  const addVariantOption = (groupIndex: number) => {
    const newGroups = [...variantGroups];
    newGroups[groupIndex].options.push({ name: "", price: "" });
    setVariantGroups(newGroups);
  };

  const handleVariantOptionChange = (
    groupIndex: number,
    optionIndex: number,
    field: keyof VariantOption,
    value: any
  ) => {
    const newGroups = [...variantGroups];
    (newGroups[groupIndex].options[optionIndex] as any)[field] = value;
    setVariantGroups(newGroups);
  };

  const removeVariantOption = (groupIndex: number, optionIndex: number) => {
    const newGroups = [...variantGroups];
    newGroups[groupIndex].options.splice(optionIndex, 1);
    setVariantGroups(newGroups);
  };

  const handleFormData = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setLoading(true);

    try {
      const fd = new FormData();
      fd.append("name", formData.name);
      fd.append("shortDescription", formData.shortDescription);
      fd.append("categoryId", formData.categoryId);
      fd.append("subcategoryId", formData.subcategoryId);
      fd.append("price", formData.price);
      fd.append("description", formData.description);
      if (formData.image) {
        fd.append("image", formData.image);
      }
      fd.append("variantGroups", JSON.stringify(variantGroups));

      const res = await api.patch(
        `/api/v1/product/update-product/${params.id}`,
        fd,
        {
          headers: { "Content-Type": "multipart/form-data" },
        }
      );

      if (res.status === 200) {
        router.push("/dashboard/products");
      }
      setLoading(false);
    } catch (error: any) {
      setError(true);
      setErrorMessage(error.message);
      setLoading(false);
    }
  };

  return (
    <section className="my-8">
      {loading && (
        <div className='fixed inset-0 z-50 flex items-center justify-center animate-fadeIn'>
          <div className='absolute inset-0 bg-black/40'></div>
          <div className='relative z-10'>
            <div className='h-12 w-12 border-4 border-white/30 border-t-white rounded-full animate-spin'></div>
          </div>
        </div>
      )}
      <div className="flex items-center justify-between mb-6">
        <h1 className="font-bold text-2xl text-gray-800">Edit Product</h1>
        <Link
          href={"/dashboard/products"}
          className="w-fit py-3 px-4 bg-gradient-to-r from-[#FE4F70] to-[#FFA387] cursor-pointer text-white rounded-full text-sm"
        >
          Go Back
        </Link>
      </div>

      <form onSubmit={handleFormData} encType="multipart/form-data">
        {error && (
          <div className="mb-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative">
            <span className="block sm:inline text-sm">{errorMessage}</span>
          </div>
        )}

        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div className="flex flex-col gap-2">
            <Label htmlFor="name">Name</Label>
            <Input
              type="text"
              id="name"
              name="name"
              placeholder="Enter Name"
              className="border border-black placeholder:text-black"
              autoComplete="off"
              required
              value={formData.name}
              onChange={handleChange}
            />
          </div>

          <div className="flex flex-col gap-2">
            <Label htmlFor="shortDescription">Short Description</Label>
            <Input
              type="text"
              id="shortDescription"
              name="shortDescription"
              placeholder="Enter Short Description"
              className="border border-black placeholder:text-black"
              autoComplete="off"
              required
              value={formData.shortDescription}
              onChange={handleChange}
            />
          </div>

          <div className="flex flex-col gap-2">
            <Label htmlFor="categoryId">Category</Label>
            <Select
              name="categoryId"
              value={formData.categoryId}
              onValueChange={(val) => handleChangeCategory(val)}
            >
              <SelectTrigger className="w-full border border-black">
                <SelectValue placeholder="Select main category" />
              </SelectTrigger>
              <SelectContent>
                <SelectGroup>
                  <SelectLabel>Main Categories</SelectLabel>
                  {mainCategories.map((cat) => (
                    <SelectItem key={cat._id} value={cat._id}>
                      {cat.name}
                    </SelectItem>
                  ))}
                </SelectGroup>
              </SelectContent>
            </Select>
          </div>

          <div className="flex flex-col gap-2">
            <Label htmlFor="subcategoryId">Subcategory</Label>
            <Select
              name="subcategoryId"
              value={formData.subcategoryId}
              onValueChange={(e) =>
                setFormData((prev) => ({ ...prev, subcategoryId: e }))
              }
            >
              <SelectTrigger className="w-full border border-black">
                <SelectValue placeholder="Select Subcategory" />
              </SelectTrigger>
              <SelectContent>
                <SelectGroup>
                  <SelectLabel>Subcategories</SelectLabel>
                  {subCategories.map((sub) => (
                    <SelectItem key={sub._id} value={sub._id}>
                      {sub.name}
                    </SelectItem>
                  ))}
                </SelectGroup>
              </SelectContent>
            </Select>
          </div>

          <div className="flex flex-col gap-2">
            <Label htmlFor="price">Price</Label>
            <Input
              type="number"
              id="price"
              name="price"
              placeholder="Enter Price"
              className="border border-black placeholder:text-black"
              autoComplete="off"
              required
              value={formData.price}
              onChange={handleChange}
            />
          </div>

          <div className="flex flex-col gap-2">
            <Label htmlFor="image">Select Image</Label>
            <Input
              type="file"
              id="image"
              name="image"
              accept="image/*"
              onChange={handleFileChange}
            />
          </div>

          <div className="flex flex-col col-span-2 gap-2">
            <Label htmlFor="description">Description</Label>
            <Textarea
              id="description"
              name="description"
              placeholder="Enter Description"
              className="h-[200px] border border-black placeholder:text-black"
              autoComplete="off"
              required
              value={formData.description}
              onChange={handleChange}
            />
          </div>
          <div className="mt-5 col-span-2">
            <div className="flex items-center justify-between mb-3">
              <h2 className="font-bold text-lg">Variant Groups</h2>
              <Button type="button" onClick={addVariantGroup}>
                + Add Group
              </Button>
            </div>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              {variantGroups.map((group, gIndex) => (
                <div
                  key={gIndex}
                  className="p-4 border border-gray-300 rounded-lg"
                >
                  <div className="flex justify-between items-center mb-2">
                    <Label>Group Name</Label>
                    <Button
                      type="button"
                      variant="destructive"
                      onClick={() => removeVariantGroup(gIndex)}
                    >
                      Remove
                    </Button>
                  </div>
                  <Input
                    placeholder="e.g., Size, Crust"
                    value={group.name}
                    onChange={(e) =>
                      handleVariantGroupChange(gIndex, "name", e.target.value)
                    }
                  />

                  <div className="mt-2 flex gap-4">
                    <label className="flex items-center gap-2">
                      <input
                        type="checkbox"
                        checked={group.isRequired}
                        onChange={(e) =>
                          handleVariantGroupChange(
                            gIndex,
                            "isRequired",
                            e.target.checked
                          )
                        }
                      />
                      Required
                    </label>
                    <Input
                      type="number"
                      placeholder="Max Selectable"
                      value={group.maxSelectable}
                      onChange={(e) =>
                        handleVariantGroupChange(
                          gIndex,
                          "maxSelectable",
                          Number(e.target.value)
                        )
                      }
                    />
                  </div>

                  <div className="mt-4">
                    <div className="flex justify-between items-center mb-2">
                      <Label>Options</Label>
                      <Button
                        type="button"
                        onClick={() => addVariantOption(gIndex)}
                      >
                        + Add Option
                      </Button>
                    </div>

                    {group.options.map((option, oIndex) => (
                      <div
                        key={oIndex}
                        className="flex gap-2 mb-2 items-center border p-2 rounded"
                      >
                        <Input
                          placeholder="Option Name (e.g., Small)"
                          value={option.name}
                          onChange={(e) =>
                            handleVariantOptionChange(
                              gIndex,
                              oIndex,
                              "name",
                              e.target.value
                            )
                          }
                        />
                        <Input
                          type="number"
                          placeholder="Price"
                          value={option.price}
                          onChange={(e) =>
                            handleVariantOptionChange(
                              gIndex,
                              oIndex,
                              "price",
                              e.target.value
                            )
                          }
                        />
                        <Button
                          type="button"
                          variant="destructive"
                          onClick={() =>
                            removeVariantOption(gIndex, oIndex)
                          }
                        >
                          X
                        </Button>
                      </div>
                    ))}
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>

        <div className="mt-6">
          <button
            type="submit"
            disabled={loading}
            className="w-full py-3 px-4 bg-gradient-to-r from-[#FE4F70] to-[#FFA387] cursor-pointer text-white rounded-full text-sm"
          >
            {loading ? "Updating..." : "Update Product"}
          </button>
        </div>
      </form>
    </section>
  );
};

export default EditProduct;
