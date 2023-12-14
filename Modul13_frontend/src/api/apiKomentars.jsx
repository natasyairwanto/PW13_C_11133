import axios from "axios";
import useAxios from ".";

const fetchData = async () => {
    try {
        
        const contentResponse = await fetchContentById(contentId);
        setContent(contentResponse);

        const commentsResponse = await fetchCommentsByContentId(contentId);
        setComments(commentsResponse);
    } catch (error) {
        console.error('Error fetching data:', error);
    }
};

const fetchContentById = async (id) => {
    try {
       
        const response = await fetch(`/api/content/${id}`);
        const data = await response.json();

        
        const { id: contentId, title, description, thumbnail } = data;

        return {
            id: contentId,
            title: title,
            description: description,
            thumbnail: thumbnail,
        };
    } catch (error) {
        console.error('Error fetching content:', error);
        
        return {
            id: id,
            title: 'Contoh Judul',
            description: 'Deskripsi konten placeholder.',
            thumbnail: 'path/to/thumbnail.jpg',
        };
    }
};


export const fetchCommentsByContentId = async (id) => {
    try {
        const response = await useAxios.get(`komentars/${id}`, {
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

export const addComment = async (contentId, komen) => {
    
    try {
        const response = await useAxios.post(`komentars/${contentId}`, {
            comment: komen
        }, {
            headers: {
                'Content-Type': 'application/json',
                Authorization: `Bearer ${sessionStorage.getItem("token")}`,
            },
        });
        return response.data;
    } catch (error) {
        throw error.response.data;
    }
};

export const editComment = async (id, updatedComment) => {
    try {
        // console.log('Payload:', { comment: updatedComment });
      const response = await useAxios.put(
        `komentars/${id}`,
        // `komentars/${contentId}/${commentId}`,
        {
            title: "Updated Title", 
            description: "Updated Description",
            comment: updatedComment,
        },
        {
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${sessionStorage.getItem("token")}`,
          },
        }
      );
      return response.data;
    } catch (error) {
        console.error('Error response:', error.response);
        if (error.response && error.response.data && error.response.data.message) {
            console.error('Error message:', error.response.data.message);
          }
      throw error.response.data;
    }
  };


export const deleteComment = async (id) => {
    
    try {
        const response = await useAxios.delete(`komentars/${id}`, {
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