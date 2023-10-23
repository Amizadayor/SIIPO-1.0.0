<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CostoOperacionEmbMa extends Model
{
    use HasFactory;
    protected $table = 'costos_operacion_emb_ma';
    protected $primaryKey = 'id';
    protected $fillable = [
        'Combustible',
        'Lubricantes',
        'Mantenimiento',
        'Salarios',
        'Seguros',
        'Permisos',
        'Impuestos',
        'Avituallamiento',
        'Preoperativos',
        'AsistenciaTecnica',
        'Administrativos',
        'Otros',
        'Total',
        'DGEMMAid',
    ];
    public $timestamps = true;
    public function DatosGeneralesEmbMa()
    {
        return $this->belongsTo(DatosGeneralesEmbMa::class, 'DGEMMAid', 'id');
    }
}
