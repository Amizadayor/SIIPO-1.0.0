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
        Schema::create('asignacion_permisos', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('Rolid');
            $table->unsignedBigInteger('Privid');
            $table->boolean('Permitido');

            $table->foreign('Rolid')->references('id')->on('Roles');
            $table->foreign('Privid')->references('id')->on('Privilegios');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('asignacion_permisos');
    }
};
