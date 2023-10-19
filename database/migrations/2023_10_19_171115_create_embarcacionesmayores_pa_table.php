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
        Schema::create('embarcacionesmayores_pa', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('DGPAid');
            $table->unsignedBigInteger('DGEMMAid');

            $table->foreign('DGPAid')->references('id')->on('datosgenerales_pa');
            $table->foreign('DGEMMAid')->references('id')->on('datosgenerales_emb_ma');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('embarcacionesmayores_pa');
    }
};
