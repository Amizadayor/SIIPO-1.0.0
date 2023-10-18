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
        Schema::create('telefonos_pa', function (Blueprint $table) {
            $table->id();
            $table->string('Numero', 10);
            $table->string('Tipo', 20);
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
        Schema::dropIfExists('telefonos_pa');
    }
};
