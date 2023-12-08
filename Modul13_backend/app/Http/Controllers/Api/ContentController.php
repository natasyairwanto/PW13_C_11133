<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Contents;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Storage;

class ContentController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $contents = Contents::inRandomOrder()->get();

        return response([
            'message' => 'All Contents Retrieved',
            'data' => $contents
        ], 200);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function showContentbyUser($id) {
        $user = User::find($id);
        if(!$user){
            return response([
                'message' => 'User Not Found',
                'data' => null
            ],404);
        }
        $contents = Contents::where('id_user', $user->id)->get();
        return response([
            'message' => 'Contents of '.$user->name.' Retrieved',
            'data' => $contents
        ],200);

    }


    public function store(Request $request)
    {
        $storeData = $request->all();

        $validate = Validator::make($storeData,[
            'title' => 'required|max:60',
            'thumbnail' => 'required|image:jpeg,png,jpg,gif,svg|max:2048',
            'description' => 'required',
        ]);
        if ($validate->fails()) {
            return response(['message'=> $validate->errors()],400);
        }
        $idUser = Auth::user()->id;
        $user = User::find($idUser);
        if(is_null($user)){
            return response([
                'message' => 'User Not Found'
            ],404);
        }
        $uploadFolder = 'contents';
        $image = $request->file('thumbnail');
        $image_uploaded_path = $image->store($uploadFolder, 'public');
        $uploadedImageResponse = basename($image_uploaded_path);

        $storeData['thumbnail'] = $uploadedImageResponse;
        $storeData['id_user'] = $user->id;

        $contents = Contents::create($storeData);
        return response([
            'message' => 'Content Added Successfully',
            'data' => $contents,
        ],200);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $contents = Contents::find($id);

        if($contents){
            return response([
                'message' => 'Content Found',
                'data' => $contents
            ],200);
        }

        return response([
            'message' => 'Content Not Found',
            'data' => null
        ],404);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $content = Contents::find($id);
        if(is_null($content)){
            return response([
                'message' => 'Content Not Found',
                'data' => null
            ],404);
        }

        $updateData = $request->all();

        $validate = Validator::make($updateData,[
            'title' => 'required|max:60',
            'description' => 'required',
        ]);
        if ($validate->fails()) {
            return response(['message'=> $validate->errors()],400);
        }
        $idUser = Auth::user()->id;
        $user = User::find($idUser);
        if(is_null($user)){
            return response([
                'message' => 'User Not Found'
            ],404);
        }
        if($request->hasFile('thumbnail')){
            // kalau kalian membaca ini, ketahuilah bahwa gambar tidak akan bisa diupdate karena menggunakan method PUT ;)
            // kalian bisa mengubahnya menjadi POST atau PATCH untuk mengupdate gambar
            $uploadFolder = 'contents';
            $image = $request->file('thumbnail');
            $image_uploaded_path = $image->store($uploadFolder, 'public');
            $uploadedImageResponse = basename($image_uploaded_path);

            // hapus data thumbnail yang lama dari storage
            Storage::disk('public')->delete('contents/'.$content->thumbnail);

            // set thumbnail yang baru
            $updateData['thumbnail'] = $uploadedImageResponse;
        }

        $content->update($updateData);

        return response([
            'message' => 'Content Updated Successfully',
            'data' => $content,
        ],200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $contents = Contents::find($id);

        if(is_null($contents)){
            return response([
                'message' => 'Content Not Found',
                'data' => null
            ],404);
        }

        if($contents->delete()){
            return response([
                'message' => 'Content Deleted Successfully',
                'data' => $contents,
            ],200);
        }

        return response([
            'message' => 'Delete Content Failed',
            'data' => null,
        ],400);
    }
}
