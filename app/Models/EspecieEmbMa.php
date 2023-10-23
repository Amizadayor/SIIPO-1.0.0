<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Especie;
use App\Models\DatosGeneralesEmbMA;

class EspecieEmbMa extends Model
{
    use HasFactory;
    protected $table = 'especies_emb_ma';

    protected $fillable = [
        'TPEspecieid',
        'DGEMMAid',
    ];

    public function Especie()
    {
        return $this->belongsTo(Especie::class, 'TPEspecieid', 'id');
    }

    public function DatosGeneralesEmbMA()
    {
        return $this->belongsTo(DatosGeneralesEmbMA::class, 'DGEMMAid', 'id');
    }
}
