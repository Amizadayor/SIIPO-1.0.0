<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('sociodetalles_pa', function (Blueprint $table) {
            $table->id();
            $table->date('IniOperaciones');
            $table->boolean('ActvPesquera');
            $table->integer('CantidadPescadores')->nullable();
            $table->string('CURP', 18);
            $table->boolean('TipoPA');
            $table->binary('DocActaNacimiento');
            $table->binary('DocActaConstitutiva');
            $table->binary('DocActaAsamblea');
            $table->binary('DocComprobanteDomicilio');
            $table->binary('DocCURP');
            $table->binary('DocIdentificacionOfc');
            $table->binary('DocRFC');
            $table->binary('DocAcreditacionRepresentanteLegal');
            $table->unsignedBigInteger('DetallesPAid');

            $table->foreign('DetallesPAid')->references('id')->on('detalles_pa');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('sociodetalles_pa');
    }
};
