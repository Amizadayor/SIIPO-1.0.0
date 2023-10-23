<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\AdmiTrabajadorIA;
use App\Models\DatosGeneralesIA;

class AdmiTrabajadorPorIA extends Model
{
    use HasFactory;
    protected $table = 'admi_trabajadorespor_ia';
    protected $primaryKey = 'id';
    protected $fillable = [
        'ATIAid',
        'DGIAid',
    ];

    public $timestamps = true;

    public function AdmiTrabajadoresIA()
    {
        return $this->belongsTo(AdmiTrabajadorIA::class, 'ATIAid');
    }
    public function DatosGeneralesIA()
    {
        return $this->belongsTo(DatosGeneralesIA::class, 'DGIAid');
    }
}
