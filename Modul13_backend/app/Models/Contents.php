<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Contents extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $table = 'contents';
    protected $primaryKey = 'id';
    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'id_user',
        'title',
        'thumbnail',
        'description',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'id_user');
    }
}
