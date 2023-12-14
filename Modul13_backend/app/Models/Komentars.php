<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Komentars extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $table = 'komentars';
    protected $primaryKey = 'id';
    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'id_user',
        'id_content',
        'comment',
        'date_added',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'id_user');
    }

    public function content(){
        return $this->belongsTo(Contents::class, 'id_content');
    }
}
