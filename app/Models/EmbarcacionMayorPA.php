<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\DatosGeneralesPA;
use App\Models\DatosGeneralesEmbMA;

class EmbarcacionMayorPA extends Model
{
    use HasFactory;
    protected $table = 'embarcacionesmayores_pa';
    protected $primaryKey = 'id';

    protected $fillable = [
        'DGPAid',
        'DGEMMAid',
    ];

    protected $timestamps = true;

    public function DatosGeneralesPA()
    {
        return $this->belongsTo(DatosGeneralesPA::class, 'DGPAid', 'id');
    }

    public function DatosGeneralesEmbMA()
    {
        return $this->belongsTo(DatosGeneralesEmbMA::class, 'DGEMMAid', 'id');
    }
}
