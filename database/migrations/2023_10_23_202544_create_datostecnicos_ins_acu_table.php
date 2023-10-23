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
        Schema::create('datostecnicos_ins_acu', function (Blueprint $table) {
            $table->id();
            $table->boolean('UsoComercial');
            $table->boolean('UsoDidacta');
            $table->boolean('UsoFomento');
            $table->boolean('UsoInvestigacion');
            $table->boolean('UsoRecreativo');
            $table->text('UsoOtro');
            $table->boolean('TipoLaboratorio');
            $table->boolean('TipoGranja');
            $table->boolean('TipoCentroAcuicola');
            $table->text('TipoOtro');
            $table->boolean('ModeloIntensivo');
            $table->boolean('ModeloSemiintensivo');
            $table->boolean('ModeloExtensivo');
            $table->boolean('ModeloHiperintensivo');
            $table->text('ModeloOtro');
            $table->decimal('AreaTotal', 10, 2)->default(0.00);
            $table->decimal('AreaAcuicola', 10, 2)->default(0.00);
            $table->text('AreaRestante');
            $table->integer('CapacidadProduccionMiles');
            $table->decimal('CapacidadProduccionToneladas', 10, 2)->default(0.00);
            $table->unsignedBigInteger('DGIAid');

            $table->foreign('DGIAid')->references('id')->on('datosgenerales_ins_acu');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('datostecnicos_ins_acu');
    }
};
