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
        Schema::create('domicilio_pa', function (Blueprint $table) {
            $table->id();
            $table->string('Calle', 70);
            $table->string('NmExterior', 6);
            $table->string('NmInterior', 6);
            $table->string('CodigoPostal', 10)->nullable();
            $table->unsignedBigInteger('LocID');
            $table->string('Colonia', 50);
            $table->string('TipoTelefono', 20);
            $table->unsignedBigInteger('DGPAID');

            $table->foreign('LocID')->references('id')->on('localidades');
            $table->foreign('DGPAID')->references('id')->on('datosgenerales_pa');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('domicilio_pa');
    }
};
