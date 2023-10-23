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
        Schema::create('admi_trabajadorespor_ia', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('ATIAid');
            $table->unsignedBigInteger('DGIAid');

            $table->foreign('ATIAid')->references('id')->on('admi_trabajadores_ia');
            $table->foreign('DGIAid')->references('id')->on('datosgenerales_ins_acu');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('admi_trabajadorespor_ia');
    }
};
