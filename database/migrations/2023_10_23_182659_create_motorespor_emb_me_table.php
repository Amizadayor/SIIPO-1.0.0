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
        Schema::create('motorespor_emb_me', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('DGEMMEid');
            $table->unsignedBigInteger('MtrEmbMeid');

            $table->foreign('DGEMMEid')->references('id')->on('datosgenerales_emb_me');
            $table->foreign('MtrEmbMeid')->references('id')->on('motores_emb_me');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('motorespor_emb_me');
    }
};
