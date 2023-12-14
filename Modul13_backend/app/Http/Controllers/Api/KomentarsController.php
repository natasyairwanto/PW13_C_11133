<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Contents;
use Illuminate\Http\Request;
use App\Models\Komentars;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Storage;

class KomentarsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $komentars = Komentars::inRandomOrder()->get()->load('content')->load('user');

        return response([
            'message' => 'All Komentars Retrieved',
            'data' => $komentars
        ], 200);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function showKomentarsbyUser($id) {
        $user = auth()->User();
        if(!$user){
            return response([
                'message' => 'User Not Found',
                'data' => null
            ],404);
        }

        $komentars = Komentars::where('id_content', $id)->with(['content', 'user'])->get();
        return response([
            'message' => 'Komentars of '.$user->name.' Retrieved',
            'data' => $komentars
        ],200);

    }


    public function store($idContent, Request $request)
    {
        $content = Contents::find($idContent);
        if(is_null($content)){
            return response([
                'message' => 'Content Not Found'
            ],404);
        }

        $storeData = $request->all();

        $validate = Validator::make($storeData,[
            'comment' => 'required',
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

        $storeData['id_user'] = $user->id;
        $storeData['id_content'] =$content->id;
        $storeData['date_added'] = date("Y-m-d H:i:s");

        $komentars = Komentars::create($storeData);
        return response([
            'message' => 'Komentars Added Successfully',
            'data' => $komentars,
        ],200);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $komentars = Komentars::find($id)->load('content')->load('user');

        if($komentars){
            return response([
                'message' => 'Komentars Found',
                'data' => $komentars
            ],200);
        }

        return response([
            'message' => 'Komentars Not Found',
            'data' => null
        ],404);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $content = Komentars::find($id);
        if(is_null($content)){
            return response([
                'message' => 'Komentars Not Found',
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
            'message' => 'Komentar berhasil diupdate',
            'data' => $content,
        ],200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $komentars = Komentars::find($id);

        if(is_null($komentars)){
            return response([
                'message' => 'Komentars Not Found',
                'data' => null
            ],404);
        }

        if($komentars->delete()){
            return response([
                'message' => 'Komentars berhasil dihapus',
                'data' => $komentars,
            ],200);
        }

        return response([
            'message' => 'Delete Komentars Failed',
            'data' => null,
        ],400);
    }

    public function getCommentsWithUser($contentId)
    {
        $komentars = Komentars::with('user')->where('content_id', $contentId)->get();

        return response()->json($komentars);
    }
}
