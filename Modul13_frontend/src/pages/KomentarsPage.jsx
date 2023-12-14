import React, { useEffect, useState } from 'react';
import { toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { useLocation } from 'react-router-dom';
import { Container, Row, Col, Alert, Stack, Form, Button, Modal, FloatingLabel, Spinner } from 'react-bootstrap';
import { getThumbnail } from "../api";
import { fetchCommentsByContentId, addComment, editComment, deleteComment } from "../api/apiKomentars";
import { GetContentById } from "../api/apiContent";
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faEdit, faTrash, faFloppyDisk, faVideo } from '@fortawesome/free-solid-svg-icons';


const KomentarsPage = () => {
    const location = useLocation();
    const contentId = new URLSearchParams(location.search).get('id');

    const [content, setContent] = useState({});
    const [comment, setComment] = useState('');
    const [comments, setComments] = useState([]);
    const [isLoading, setIsLoading] = useState(false);
    const [isPending, setIsPending] = useState(false);
    const [showDeleteModal, setShowDeleteModal] = useState(false);
    const [commentToDelete, setCommentToDelete] = useState({
        id: null,
        text: '',
    });
    const [showEditModal, setShowEditModal] = useState(false);
    const [loggedInUser, setLoggedInUser] = useState(null);

    const handleCloseDeleteModal = () => setShowDeleteModal(false);
    const handleShowDeleteModal = (commentId, commentText) => {
        setCommentToDelete({ id: commentId, text: commentText });
        setShowDeleteModal(true);
    };

    const hapusComment = (id) => {
        setIsPending(true);
        deleteComment(id)
            .then((response) => {
                setIsPending(false);
                toast.success(response.message);
                setComments((prevComments) =>
                    prevComments.filter((comment) => comment.id !== id)
                );
                handleCloseDeleteModal();
            })
            .catch((err) => {
                console.log(err);
                setIsPending(false);
                toast.dark(err.message);
            });
    };

    const handleCloseEditModal = () => setShowEditModal(false);
    const handleShowEditModal = (commentId, commentText) => {
        console.log('Comment ID to edit modal:', commentId);
        setCommentToDelete({ id: commentId, text: commentText });
        setComment(commentText);
        setShowEditModal(true);
    };

    const editCommentHandler = (id) => {
        console.log('Comment ID to be edited:', id);
        setIsPending(true);
        editComment(id, comment)
            .then((response) => {
                setIsPending(false);
                toast.success(response.message);
                fetchComments();
                setComment("");
                handleCloseEditModal();
            })
            .catch((err) => {
                console.log(err);
                setIsPending(false);
                toast.dark(err.message);

                // if (err.response && err.response.data && err.response.data.message) {
                //     toast.error(err.response.data.message);
                // } else {
                //     toast.dark("An error occurred while updating the comment.");
                // }
            });
    };

    const fetchContents = () => {

        setIsLoading(true);
        GetContentById(contentId).then((response) => {
            setContent(response);
            setIsLoading(false);
        }).catch((err) => {
            console.log(err);
            setIsLoading(false);
        })
    }

    const fetchComments = () => {

        setIsLoading(true);
        fetchCommentsByContentId(contentId).then((response) => {
            setComments(response);
            console.log(response);
            setIsLoading(false);
        }).catch((err) => {
            setIsLoading(false);
        })
    }

    const tambahComment = (event) => {
        
        event.preventDefault();

        if (comment.trim() === '') {
            toast.error("Komentar Tidak Boleh Kosong!");
            return;
        }

        addComment(contentId, comment)
            .then((result) => {
                console.log('Berhasil menambahkan komentar:', result);
                fetchComments();
                setIsLoading(true);
                setComment("");
                toast.success("Komentar berhasil ditambahkan!");
            })
            .catch((error) => {
                console.error('Gagal menambahkan komentar:', error);
            });

    }


    useEffect(() => {
        const userFromSession = sessionStorage.getItem("user");
        if (userFromSession) {
            const user = JSON.parse(userFromSession);
            setLoggedInUser(user);
        }

        fetchContents();
        fetchComments();

    }, []);


    return (
        <Container className="mt-4">

            {isLoading ? (

                <div className="text-center">
                    <Spinner
                        as="span"
                        animation="border"
                        variant="primary"
                        size="lg"
                        role="status"
                        aria-hidden="true"
                    />
                    <h6 className="mt-2 mb-0">Loading...</h6>
                </div>
            ) : (

                <>

                    <Stack direction="horizontal" gap={3} className="mb-3">
                        <h1 className="h4 fw-bold mb-0 text-nowrap">Comment Video</h1>
                        <hr className="border-top border-light opacity-50 w-100" />
                    </Stack>
                    <Row>
                        <Col md={12} className="mb-3">
                            {/* {JSON.stringify(comments)} */}
                            <div className="card text-white">
                                <img
                                    src={getThumbnail(content.thumbnail)}
                                    className="card-img w-100 h-100 object-fit-cover bg-light"
                                    alt="..."
                                />
                                <div className="card-body">
                                    <div className="d-flex align-items-center mb-2">
                                        <FontAwesomeIcon icon={faVideo} className="me-2 fs-2" />
                                        <h3 className="card-title text-truncate mb-0">
                                            {content.title}
                                        </h3>
                                    </div>
                                    <p className="card-text">{content.description}</p>
                                </div>
                            </div>

                            <h5 className="card-title" style={{ marginTop: '10px' }}> <strong>Comments</strong></h5>
                            <p> Tuliskan komentar baru: </p>


                            <Form onSubmit={tambahComment} className="mb-3">
                                <div className="d-flex">
                                    <FloatingLabel controlId="floatingComment" label="Add New Comment" className="flex-grow-1">
                                        <Form.Control
                                            type="text"
                                            placeholder="Add New Comment"
                                            value={comment}
                                            onChange={(e) => setComment(e.target.value)}
                                            style={{ backgroundColor: 'transparent', border: '0.5px solid rgba(169, 169, 169, 0.8)' }}
                                        />
                                    </FloatingLabel>
                                    <Button variant="primary" type="submit" className="ms-2" style={{ width: '120px' }}>
                                        Kirim
                                    </Button>
                                </div>
                            </Form>


                            <div className="card-body" style={{ marginTop: '10px' }}>
                                {/* <h5 className="card-title">Komentar</h5> */}
                                {comments.length > 0 ? (
                                    comments.map((data) => (
                                        // <p 

                                        // key={data.id}>{data.comment}
                                        // {/* data.user.handle */}
                                        // </p>
                                        <div className="card" key={data.id} style={{ marginTop: '15px' }}>
                                            <div className="card-body">
                                                <div className="d-flex align-items-center justify-content-between">
                                                    <div className="d-flex align-items-center">

                                                        <img
                                                            src="https://i.pinimg.com/236x/db/c6/7a/dbc67a1d27f51a1c875cc464caaf2ef9.jpg"
                                                            alt="Profile"
                                                            className="rounded-circle mr-3"
                                                            style={{ width: '80px', height: '80px', marginRight: '15px' }}
                                                        />
                                                        <div>
                                                            <h5 className="card-title">@{data.user.handle}</h5>
                                                            <p>{data.comment}</p>

                                                        </div>
                                                    </div>

                                                    <div className="d-flex">
                                                        {/* <p className="text-muted" style={{ marginRight: '15px' }} >{data.date_added}</p> */}
                                                        <p className="text-muted" style={{ marginRight: '15px' }}>
                                                            {new Date(data.date_added).toLocaleString('en-US', {
                                                                month: 'long',
                                                                day: 'numeric',
                                                                year: 'numeric',
                                                                hour: 'numeric',
                                                                minute: 'numeric',
                                                                hour12: true,
                                                            })}
                                                        </p>

                                                        {loggedInUser && loggedInUser.id === data.user.id && (
                                                            <div className="d-flex">
                                                                <button className="btn btn-primary mr-2" style={{ marginRight: '7px' }} onClick={() => handleShowEditModal(data.id, data.comment)}>
                                                                    <FontAwesomeIcon icon={faEdit} />
                                                                </button>
                                                                <button className="btn btn-danger" onClick={() => handleShowDeleteModal(data.id, data.comment)}>
                                                                    <FontAwesomeIcon icon={faTrash} />
                                                                </button>
                                                            </div>
                                                        )}

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    ))
                                ) : (
                                    <Alert variant="dark" className="text-center">
                                        Belum ada komentar, ayo tambahin komentar!
                                    </Alert>
                                )}
                            </div>

                            <Modal show={showDeleteModal} onHide={handleCloseDeleteModal}>
                                <Modal.Header closeButton>
                                    <Modal.Title>Hapus Comment</Modal.Title>
                                </Modal.Header>
                                <Modal.Body>
                                    Apakah Anda yakin dengan sungguh-sungguh ingin menghapus comment ini:
                                    <h5 style={{ marginTop: '5px' }}><strong>{commentToDelete.text}</strong></h5>
                                </Modal.Body>
                                <Modal.Footer>
                                    <Button variant="danger" onClick={() => hapusComment(commentToDelete.id)}>
                                        <FontAwesomeIcon icon={faTrash} /> Hapus
                                    </Button>
                                </Modal.Footer>
                            </Modal>

                            <Modal show={showEditModal} onHide={handleCloseEditModal}>
                                <Modal.Header closeButton>
                                    <Modal.Title>Edit Comment</Modal.Title>
                                </Modal.Header>
                                <Modal.Body>
                                    <Form onSubmit={(e) => {
                                        e.preventDefault();
                                        editCommentHandler(commentToDelete.id);
                                    }}>
                        

                                        <div className="d-flex">
                                            <FloatingLabel controlId="floatingComment" label="Comment Content" className="flex-grow-1 mb-3">
                                                <Form.Control
                                                    type="text"
                                                    placeholder="Comment Content"
                                                    value={comment}
                                                    onChange={(e) => setComment(e.target.value)}
                                                />
                                            </FloatingLabel>
                                        </div>


                                        <div className="d-flex justify-content-end"> 
                                            <Button variant="primary" type="submit">
                                                <FontAwesomeIcon icon={faFloppyDisk} className="me-2" />
                                                Update Comment
                                            </Button>
                                        </div>
                                    </Form>
                                </Modal.Body>
                            </Modal>

                        </Col>
                    </Row>
                </>
            )}
        </Container>
    );
};

export default KomentarsPage;
