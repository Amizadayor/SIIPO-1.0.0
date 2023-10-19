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
        Schema::create('detalles_pa', function (Blueprint $table) {
            $table->id();
            $table->date('IniOperaciones');
            $table->boolean('ActvPesquera');
            $table->boolean('ActivoEmbMayor');
            $table->boolean('ActivoEmbMenor');
            $table->binary('DocActaNacimiento');
            $table->binary('DocComprobanteDomicilio');
            $table->binary('DocCURP');
            $table->binary('DocIdentificacionOfc');
            $table->binary('DocRFC');
            $table->unsignedBigInteger('DGPAid');

            $table->foreign('DGPAid')->references('id')->on('datosgenerales_pa');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('detalles_pa');
    }
};
