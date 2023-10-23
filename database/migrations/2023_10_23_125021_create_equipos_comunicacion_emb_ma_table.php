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
        Schema::create('equipos_comunicacion_emb_ma', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('EqpoComunicacionid');
            $table->unsignedBigInteger('DGEMMAid');

            $table->foreign('EqpoComunicacionid')->references('id')->on('equipos_comunicacion');
            $table->foreign('DGEMMAid')->references('id')->on('datosgenerales_emb_ma');

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('equipos_comunicacion_emb_ma');
    }
};
