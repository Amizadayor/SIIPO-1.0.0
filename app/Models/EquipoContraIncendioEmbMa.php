<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\EquipoContraIncendio;
use App\Models\DatosGeneralesEmbMa;

class EquipoContraIncendioEmbMa extends Model
{
    use HasFactory;
    protected $table = 'equipos_contraincendio_emb_ma';

    protected $fillable = [
        'EqpoContraIncendioid',
        'DGEMMAid',
    ];

    public function EquipoContraIncendio()
    {
        return $this->belongsTo(EquipoContraIncendio::class, 'EqpoContraIncendioid', 'id');
    }

    public function DatosGeneralesEmbMa()
    {
        return $this->belongsTo(DatosGeneralesEmbMa::class, 'DGEMMAid', 'id');
    }
}
