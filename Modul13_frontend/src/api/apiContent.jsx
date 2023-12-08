import useAxios from ".";

// Mendapatkan semua content untuk ditaruh di halaman dashboard
export const GetAllContents = async () => {
    try {
        const response = await useAxios.get("/contents", {
            headers: {
                "Content-Type": "application/json",
                Authorization: `Bearer ${sessionStorage.getItem("token")}`,
            },
        });
        return response.data.data;
    } catch (error) {
        throw error.response.data;
    }
};

// Mendapatkan semua content user yang sedang login
export const GetMyContents = async () => {
    const id = JSON.parse(sessionStorage.getItem("user")).id;
    try {
        const response = await useAxios.get(`/contents/user/${id}`, {
            headers: {
                "Content-Type": "application/json",
                Authorization: `Bearer ${sessionStorage.getItem("token")}`,
            },
        });
        return response.data.data;
    } catch (error) {
        throw error.response.data;
    }
};

// [Tidak dipakai] Mendapatkan content by id user
export const GetContentById = async (id) => {
    try {
        const response = await useAxios.get(`/contents/${id}`, {
            headers: {
                "Content-Type": "application/json",
                Authorization: `Bearer ${sessionStorage.getItem("token")}`,
            },
        });
        return response.data.data;
    } catch (error) {
        throw error.response.data;
    }
};

// Membuat content baru
export const CreateContent = async (data) => {
    try {
        const response = await useAxios.post("/contents", data, {
            headers: {
                "Content-Type": "multipart/form-data", // untuk upload thumbnail
                Authorization: `Bearer ${sessionStorage.getItem("token")}`,
            },
        });
        return response.data;
    } catch (error) {
        throw error.response.data;
    }
};

// Mengedit content
export const UpdateContent = async (values) => {
    try {
        const response = await useAxios.put(`/contents/${values.id}`, values, {
            headers: {
                "Content-Type": "application/json",
                Authorization: `Bearer ${sessionStorage.getItem("token")}`,
            },
        });
        return response.data;
    } catch (error) {
        throw error.response.data;
    }
};

// Menghapus content
export const DeleteContent = async (id) => {
    await new Promise((resolve) => setTimeout(resolve, 1000));
    try {
        const response = await useAxios.delete(`/contents/${id}`, {
            headers: {
                "Content-Type": "application/json",
                Authorization: `Bearer ${sessionStorage.getItem("token")}`,
            },
        });
        return response.data;
    } catch (error) {
        throw error.response.data;
    }
};
