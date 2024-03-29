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
        Schema::create('motorespor_emb_ma', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('DGEMMAid');
            $table->unsignedBigInteger('MtrEmbMaid');

            $table->foreign('DGEMMAid')->references('id')->on('datosgenerales_emb_ma');
            $table->foreign('MtrEmbMaid')->references('id')->on('motores_emb_ma');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('motorespor_emb_ma');
    }
};
