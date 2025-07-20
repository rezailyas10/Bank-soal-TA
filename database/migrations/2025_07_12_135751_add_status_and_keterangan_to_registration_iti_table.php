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
        Schema::table('registration_iti', function (Blueprint $table) {
            $table->enum('status', ['belum dihubungi', 'sudah dihubungi'])
                  ->default('belum dihubungi')
                  ->after('agree_to_contact');
            $table->text('keterangan')->nullable()->after('status');
        });
    }

    public function down(): void
    {
        Schema::table('registration_iti', function (Blueprint $table) {
            $table->dropColumn(['status', 'keterangan']);
        });
    }
};
