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
        Schema::create('artes_equipopescapor_emb_me', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('DGEMMEid');
            $table->unsignedBigInteger('ArteEquipoPescaEmbMeid');

            $table->foreign('DGEMMEid')->references('id')->on('datosgenerales_emb_me');
            $table->foreign('ArteEquipoPescaEmbMeid')->references('id')->on('artes_equipo_pesca_emb_me');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('artes_equipopescapor_emb_me');
    }
};
