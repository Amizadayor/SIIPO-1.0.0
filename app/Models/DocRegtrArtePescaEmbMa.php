<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DocRegtrArtePescaEmbMa extends Model
{
    use HasFactory;
    protected $table = 'docs_regtrartespesca_emb_ma';
    protected $fillable = [
        'DocFacturaElectronica',
        'DocNotaRemision',
        'DocFacturaEndosada',
        'DocTestimonial',
        'ArteEquipoPescaEmbMaID',
    ];

    public function ArteEquipoPescaEmbMa()
    {
        return $this->belongsTo(ArteEquipoPescaEmbMa::class, 'ArteEquipoPescaEmMaID', 'id');
    }
}
