<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\DatosGeneralesEmbMe;
use App\Models\ArteEquipoPescaEmbMe;

class ArteEquipoPescaPorEmbMe extends Model
{
    use HasFactory;
    protected $table = 'artes_equipopescapor_emb_me';

    protected $primaryKey = 'id';
    protected $fillable = [
        'DGEMMEid',
        'ArteEquipoPescaEmbMeid',
    ];

    public $timestamps = true;
    public function DatosGeneralesEmbMe()
    {
        return $this->belongsTo(DatosGeneralesEmbMe::class, 'DGEMMEid', 'id');
    }

    public function ArteEquipoPescaEmbMe()
    {
        return $this->belongsTo(ArteEquipoPescaEmbMe::class, 'ArteEquipoPescaEmbMeid', 'id');
    }
}
