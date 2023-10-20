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
        Schema::create('artes_pesca_emb_ma', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('TPArtPescaid');
            $table->unsignedBigInteger('DGEMMAid');

            $table->foreign('TPArtPescaid')->references('id')->on('artes_pesca');
            $table->foreign('DGEMMAid')->references('id')->on('datosgenerales_emb_ma');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('artes_pesca_emb_ma');
    }
};
