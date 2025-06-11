@extends('layouts.mitra')

@section('title')
Analisis Soal - {{ $exam->title }}
@endsection
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.27.2/axios.min.js"></script>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f8fafc;
            color: #334155;
            line-height: 1.6;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .header {
            background: linear-gradient(135deg, #3b82f6 0%, #6366f1 100%);
            color: white;
            padding: 30px;
            border-radius: 12px;
            margin-bottom: 30px;
            text-align: center;
        }
        
        .header h1 {
            font-size: 2rem;
            margin-bottom: 8px;
        }
        
        .header p {
            opacity: 0.9;
            font-size: 1.1rem;
        }

        .action-section {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            font-size: 1rem;
            transition: all 0.2s ease;
        }

        .btn-primary {
            background: #3b82f6;
            color: white;
        }

        .btn-primary:hover {
            background: #2563eb;
        }

        .btn-danger {
            background: #ef4444;
            color: white;
        }

        .btn-danger:hover {
            background: #dc2626;
        }

        .btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
        }

        .loading {
            display: none;
            text-align: center;
            color: #6b7280;
            font-weight: 500;
        }

        .spinner {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 2px solid #e5e7eb;
            border-top: 2px solid #3b82f6;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin-right: 10px;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: none;
        }

        .alert-success {
            background: #dcfce7;
            border: 1px solid #86efac;
            color: #166534;
        }

        .alert-error {
            background: #fef2f2;
            border: 1px solid #fca5a5;
            color: #dc2626;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            text-align: center;
        }
        
        .stat-card h3 {
            color: #6b7280;
            font-size: 0.9rem;
            margin-bottom: 8px;
            font-weight: 500;
        }
        
        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: #3b82f6;
        }
        
        .tabs {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .tab-header {
            display: flex;
            background: #f8fafc;
            overflow-x: auto;
        }
        
        .tab-button {
            padding: 15px 25px;
            background: transparent;
            border: none;
            cursor: pointer;
            font-weight: 600;
            color: #6b7280;
            border-bottom: 2px solid transparent;
            white-space: nowrap;
            transition: all 0.2s ease;
        }
        
        .tab-button.active {
            color: #3b82f6;
            border-bottom-color: #3b82f6;
            background: white;
        }
        
        .tab-content {
            display: none;
            padding: 25px;
        }
        
        .tab-content.active {
            display: block;
        }

        .category-selector {
            margin-bottom: 20px;
        }

        .category-selector select {
            padding: 10px 15px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 1rem;
            background: white;
            min-width: 250px;
        }
        
        .table-wrapper {
            overflow-x: auto;
            border-radius: 8px;
            border: 1px solid #e5e7eb;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            min-width: 600px;
        }
        
        th {
            background: #f8fafc;
            padding: 12px;
            text-align: left;
            font-weight: 600;
            color: #374151;
            border-bottom: 1px solid #e5e7eb;
        }
        
        td {
            padding: 12px;
            border-bottom: 1px solid #f3f4f6;
        }
        
        tr:hover {
            background: #f8fafc;
        }
        
        .score-high { color: #059669; font-weight: 600; }
        .score-medium { color: #d97706; font-weight: 600; }
        .score-low { color: #dc2626; font-weight: 600; }

        .difficulty-easy { 
            background: #dcfce7; 
            color: #166534; 
            padding: 4px 8px; 
            border-radius: 4px; 
            font-size: 0.85rem;
            font-weight: 600;
        }

        .difficulty-medium { 
            background: #fef3c7; 
            color: #d97706; 
            padding: 4px 8px; 
            border-radius: 4px; 
            font-size: 0.85rem;
            font-weight: 600;
        }

        .difficulty-hard { 
            background: #fef2f2; 
            color: #dc2626; 
            padding: 4px 8px; 
            border-radius: 4px; 
            font-size: 0.85rem;
            font-weight: 600;
        }

        .correct { color: #059669; font-weight: 600; }
        .incorrect { color: #dc2626; }
        
        .no-data {
            text-align: center;
            padding: 40px;
            color: #6b7280;
        }

        .no-data-icon {
            font-size: 3rem;
            margin-bottom: 15px;
        }
        
        @media (max-width: 768px) {
            .container { padding: 15px; }
            .stats-grid { grid-template-columns: 1fr; }
            .action-buttons { flex-direction: column; }
            .tab-header { flex-direction: column; }
            .category-selector select { min-width: 100%; }
        }
    </style>

    @section('content')
<div class="container">
        <!-- Header -->
        <div class="header">
            <h1>📊 Analisis Soal dan Nilai</h1>
            <p>{{ $exam->title }}</p>
        </div>

        <!-- Action Section -->
        <div class="action-section">
            <div id="alertSuccess" class="alert alert-success">
                <span id="successMessage"></span>
            </div>
            
            <div id="alertError" class="alert alert-error">
                <span id="errorMessage"></span>
            </div>

            <div class="action-buttons">
                <button id="calculateBtn" class="btn btn-primary">
                    🧮 Hitung Analisis IRT
                </button>
                <button id="resetBtn" class="btn btn-danger">
                    🗑️ Reset Semua Nilai
                </button>
            </div>

            <div id="loadingIndicator" class="loading">
                <span class="spinner"></span>
                Sedang memproses analisis...
            </div>
        </div>

        <!-- Statistics Overview -->
        <div class="stats-grid">
            <div class="stat-card">
                <h3>Total Soal</h3>
                <div class="stat-value">{{ $exam->questions->count() }}</div>
            </div>
            <div class="stat-card">
                <h3>Total Peserta</h3>
                <div class="stat-value">{{ $totalParticipants }}</div>
            </div>
            <div class="stat-card">
                <h3>Mata Pelajaran</h3>
                <div class="stat-value">{{ $questionsBySubCategory->count() }}</div>
            </div>
        </div>

        <!-- Main Content Tabs -->
        <div class="tabs">
            <div class="tab-header">
                <button class="tab-button active" onclick="showTab('questions')">📝 Analisis Soal</button>
                <button class="tab-button" onclick="showTab('participants')">📝 Hasil Peserta</button>
                <button class="tab-button" onclick="showTab('results')">🎯 Hasil IRT</button>
                <button class="tab-button" onclick="showTab('responses')">📊 Data Jawaban</button>
            </div>

            <!-- Questions Analysis Tab -->
            <div id="questions" class="tab-content active">
                @foreach($questionsBySubCategory as $subCategoryName => $questions)
                <div style="margin-bottom: 30px;">
                    <h3 style="color: #3b82f6; margin-bottom: 15px; font-size: 1.3rem;">📚 {{ $subCategoryName }}</h3>
                    <div class="table-wrapper">
                        <table>
                            <thead>
                                <tr>
                                    <th>No. Soal</th>
                                    <th>Pertanyaan</th>
                                    <th>Total Peserta</th>
                                    <th>Jawaban Benar</th>
                                    <th>Persentase Benar</th>
                                    <th>Tingkat Kesulitan</th>
                                    <th>Nilai Pertanyaan</th>
                                    <th>Detail Soal</th>
                                </tr>
                            </thead>
                            <tbody>
                               @foreach ($questions as $index => $question)
                                <tr>
                                    <td><strong>{{ $index + 1 }}</strong></td>
                                    <td style="max-width: 300px;">
                                        {{ \Illuminate\Support\Str::words(strip_tags($question->question_text), 5, '...') }}
                                    </td>
                                    <td>{{ $question->total_participants }}</td>
                                    <td class="correct">{{ $question->correct_answers }}</td>
                                    <td><strong>{{ $question->correct_percentage }}%</strong></td>
                                    <td>
                                        <span class="difficulty-{{ strtolower($question->difficulty_category) === 'mudah' ? 'easy' : (strtolower($question->difficulty_category) === 'sedang' ? 'medium' : 'hard') }}">
                                            {{ $question->difficulty_category }}
                                        </span>
                                    </td>
                                    <td>{{ $question->question_score }}</td>
                                    <td>
                                         <a href="{{ route('question.show', $question->id) }}" class="btn btn-sm btn-warning float-right">Detail</a>
                                    </td>
                                </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>
                @endforeach
            </div>
            <!-- Results Analysis Tab -->
           <div id="participants" class="tab-content active">
    @foreach($questionsBySubCategory as $subCategoryName => $questions)
    <div style="margin-bottom: 30px;">
        <h3 style="color: #3b82f6; margin-bottom: 15px; font-size: 1.3rem;">📚 {{ $subCategoryName }}</h3>

        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Nama Peserta</th>
                        <th>Nilai Rata-Rata</th>
                    </tr>
                </thead>
                <tbody>
                    @php $no = 1; @endphp
                    @foreach($exam->results as $result)
                        @php
                            // Ambil rata-rata skor peserta untuk subcategory ini
                            $avgScore = $averageScoresByResult[$result->id][$subCategoryName] ?? null;
                        @endphp

                        @if($avgScore !== null)
                        <tr>
                            <td><strong>{{ $no++ }}</strong></td>
                            <td>{{ $result->user->name ?? 'Nama tidak ditemukan' }}</td>
                            <td>{{ number_format($avgScore, 2) }}</td>
                        </tr>
                        @endif
                    @endforeach

                    @if($no === 1)
                    <tr>
                        <td colspan="3" style="text-align: center;">Tidak ada data peserta pada subcategory ini.</td>
                    </tr>
                    @endif
                </tbody>
            </table>
        </div>
    </div>
    @endforeach
</div>


            <!-- Results Tab -->
            <div id="results" class="tab-content">
                <div class="category-selector">
                    <label for="resultCategory" style="font-weight: 600; margin-right: 10px;">Pilih Mata Pelajaran:</label>
                    <select id="resultCategory" onchange="showResults()">
                        <option value="">-- Pilih Mata Pelajaran --</option>
                        @foreach($questionsBySubCategory->keys() as $subCategory)
                        <option value="{{ $subCategory }}">{{ $subCategory }}</option>
                        @endforeach
                    </select>
                </div>

                <div id="resultsContent">
                    <div class="no-data">
                        <div class="no-data-icon">📊</div>
                        <div>Pilih mata pelajaran dan jalankan analisis IRT untuk melihat hasil</div>
                    </div>
                </div>
            </div>

            <!-- Response Data Tab -->
            <div id="responses" class="tab-content">
                <div class="category-selector">
                    <label for="responseCategory" style="font-weight: 600; margin-right: 10px;">Pilih Mata Pelajaran:</label>
                    <select id="responseCategory" onchange="showResponses()">
                        <option value="">-- Pilih Mata Pelajaran --</option>
                        @foreach($questionsBySubCategory->keys() as $subCategory)
                        <option value="{{ $subCategory }}">{{ $subCategory }}</option>
                        @endforeach
                    </select>
                </div>

                <div id="responsesContent">
                    <div class="no-data">
                        <div class="no-data-icon">📝</div>
                        <div>Pilih mata pelajaran untuk melihat data jawaban peserta</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        // Global variables
        let irtData = null;
        const examSlug = '{{ $exam->slug }}';

        // Setup CSRF token
        axios.defaults.headers.common['X-CSRF-TOKEN'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

        // Tab switching
        function showTab(tabId) {
            document.querySelectorAll('.tab-content').forEach(content => {
                content.classList.remove('active');
            });
            document.querySelectorAll('.tab-button').forEach(button => {
                button.classList.remove('active');
            });
            
            document.getElementById(tabId).classList.add('active');
            event.target.classList.add('active');
        }

        // Show alerts
        function showAlert(type, message) {
            const alertElement = document.getElementById(type === 'success' ? 'alertSuccess' : 'alertError');
            const messageElement = document.getElementById(type === 'success' ? 'successMessage' : 'errorMessage');
            
            messageElement.textContent = message;
            alertElement.style.display = 'block';
            
            setTimeout(() => {
                alertElement.style.display = 'none';
            }, 5000);
        }

        // Calculate IRT
        document.getElementById('calculateBtn').addEventListener('click', async function() {
            const btn = this;
            const loading = document.getElementById('loadingIndicator');
            
            btn.disabled = true;
            loading.style.display = 'block';
            
            try {
                const response = await axios.post(`/mitra/nilai-tryout/${examSlug}/calculate-irt`);
                
                if (response.data.success) {
                    irtData = response.data.data;
                    console.log('IRT Data received:', irtData); // Debug log
                    showAlert('success', 'Analisis IRT berhasil dihitung!');
                    
                    // Refresh active views
                    if (document.getElementById('resultCategory').value) {
                        showResults();
                    }
                } else {
                    showAlert('error', response.data.message || 'Terjadi kesalahan');
                }
            } catch (error) {
                console.error('Error:', error);
                showAlert('error', 'Error: ' + (error.response?.data?.message || error.message));
            } finally {
                btn.disabled = false;
                loading.style.display = 'none';
            }
        });

        // Reset scores
        document.getElementById('resetBtn').addEventListener('click', async function() {
            if (!confirm('Yakin ingin mereset semua nilai ke 0? Tindakan ini tidak dapat dibatalkan.')) {
                return;
            }

            const btn = this;
            btn.disabled = true;
            
            try {
                const response = await axios.post(`/mitra/nilai-tryout/${examSlug}/reset-scores`);
                
                if (response.data.success) {
                    irtData = null;
                    showAlert('success', 'Semua nilai berhasil direset!');
                    
                    // Reset selectors
                    document.getElementById('resultCategory').value = '';
                    document.getElementById('responseCategory').value = '';
                    
                    // Clear content
                    document.getElementById('resultsContent').innerHTML = `
                        <div class="no-data">
                            <div class="no-data-icon">📊</div>
                            <div>Nilai telah direset. Pilih mata pelajaran dan jalankan analisis untuk melihat hasil baru</div>
                        </div>
                    `;
                    document.getElementById('responsesContent').innerHTML = `
                        <div class="no-data">
                            <div class="no-data-icon">📝</div>
                            <div>Pilih mata pelajaran untuk melihat data jawaban peserta</div>
                        </div>
                    `;
                } else {
                    showAlert('error', response.data.message || 'Terjadi kesalahan');
                }
            } catch (error) {
                console.error('Error:', error);
                showAlert('error', 'Error: ' + (error.response?.data?.message || error.message));
            } finally {
                btn.disabled = false;
            }
        });

        // Show results for selected category - FIXED VERSION
       function showResults() {
    const selectedCategory = document.getElementById('resultCategory').value;
    const contentDiv = document.getElementById('resultsContent');
    
    if (!selectedCategory) {
        contentDiv.innerHTML = `
            <div class="no-data">
                <div class="no-data-icon">📊</div>
                <div>Pilih mata pelajaran untuk melihat hasil</div>
            </div>
        `;
        return;
    }

    console.log('Selected category:', selectedCategory);
    console.log('Available IRT data:', irtData);

    if (!irtData || !irtData[selectedCategory]) {
        contentDiv.innerHTML = `
            <div class="no-data">
                <div class="no-data-icon">⚠️</div>
                <div>Silakan jalankan analisis IRT terlebih dahulu</div>
            </div>
        `;
        return;
    }

    // Extract data from the correct structure
    const categoryData = irtData[selectedCategory];
    console.log('Category data:', categoryData);
    
    // Check if irt_results exists
    if (!categoryData.irt_results) {
        contentDiv.innerHTML = `
            <div class="no-data">
                <div class="no-data-icon">❌</div>
                <div>Data IRT tidak valid untuk mata pelajaran ini</div>
            </div>
        `;
        return;
    }

    const results = categoryData.irt_results.person_results;
    const stats = categoryData.irt_results.summary_stats;
    
    console.log('Results:', results);
    console.log('Stats:', stats);

    // Check if required data exists
    if (!results || !stats) {
        contentDiv.innerHTML = `
            <div class="no-data">
                <div class="no-data-icon">❌</div>
                <div>Data hasil tidak lengkap</div>
            </div>
        `;
        return;
    }

    // Fetch detailed scores per subcategory for each user
    fetchDetailedScores(selectedCategory, results, stats, contentDiv);
}

// New function to fetch detailed scores per subcategory
// Fixed fetchDetailedScores function
async function fetchDetailedScores(selectedCategory, results, stats, contentDiv) {
    try {
        // Make sure the URL matches your route exactly
        // If you're in mitra panel, the URL should include /mitra prefix
        const response = await axios.get(`/mitra/nilai-tryout/${examSlug}/detailed-scores/${encodeURIComponent(selectedCategory)}`);
        
        if (!response.data.success) {
            throw new Error('Gagal memuat data skor detail');
        }

        const detailedScores = response.data.data;
        console.log('Detailed scores:', detailedScores);

        // Rest of your code remains the same...
        const utbkStats = stats.utbk_score || {};

        contentDiv.innerHTML = `
         <!-- Summary Stats -->
            <div class="stats-grid" style="margin-bottom: 25px;">
                <div class="stat-card">
                    <h3>Rata-rata Nilai</h3>
                    <div class="stat-value">${Math.round(response.data.utbk_score.mean || 0)}</div>
                </div>
                <div class="stat-card">
                    <h3>Nilai Tertinggi</h3>
                  <div class="stat-value">${Math.round(response.data.utbk_score.max || 0)}</div>
                </div>
                <div class="stat-card">
                    <h3>Nilai Terendah</h3>
                   <div class="stat-value">${Math.round(response.data.utbk_score.min || 0)}</div>
                </div>
                <div class="stat-card">
                    <h3>Std Deviasi</h3>
                    <div class="stat-value">${Math.round(response.data.utbk_score.std || 0)}</div>
                </div>
            </div>

            <!-- Results Table -->
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>Nama Peserta</th>
                            <th>Jumlah Benar</th>
                            <th>Rata-rata Skor ${selectedCategory}</th>
                            <th>Kategori</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${results.map(result => {
                            const userDetailScore = detailedScores.find(ds => ds.user_id == result.user_id);
                            const averageScore = userDetailScore ? userDetailScore.average_score : 0;
                            
                            let category = 'Kurang';
                            let scoreClass = 'score-low';
                            
                            if (averageScore >= 650) {
                                category = 'Sangat Baik';
                                scoreClass = 'score-high';
                            } else if (averageScore >= 550) {
                                category = 'Baik';
                                scoreClass = 'score-high';
                            } else if (averageScore >= 450) {
                                category = 'Cukup';
                                scoreClass = 'score-medium';
                            }
                            
                            return `
                                <tr>
                                    <td><strong>${result.user_name || 'N/A'}</strong></td>
                                    <td>${result.raw_score || 0}</td>
                                    <td class="${scoreClass}">${averageScore.toFixed(2)}</td>
                                    <td>${category}</td>
                                </tr>
                            `;
                        }).join('')}
                    </tbody>
                </table>
            </div>
        `;

    } catch (error) {
        console.error('Error fetching detailed scores:', error);
        
        // More detailed error logging
        if (error.response) {
            console.log('Error status:', error.response.status);
            console.log('Error data:', error.response.data);
        }
        
        contentDiv.innerHTML = `
            <div class="no-data">
                <div class="no-data-icon">❌</div>
                <div>Error memuat data skor: ${error.message}</div>
                <div style="font-size: 12px; color: #666; margin-top: 5px;">
                    Status: ${error.response?.status || 'Unknown'}
                </div>
            </div>
        `;
    }
}

        // Show responses for selected category
        function showResponses() {
            const selectedCategory = document.getElementById('responseCategory').value;
            const contentDiv = document.getElementById('responsesContent');

            if (!selectedCategory) {
                contentDiv.innerHTML = `
                    <div class="no-data">
                        <div class="no-data-icon">📝</div>
                        <div>Pilih mata pelajaran untuk melihat data jawaban</div>
                    </div>
                `;
                return;
            }

            // Fetch response data
            fetchResponseData(selectedCategory);
        }

        // Fetch response data
        async function fetchResponseData(category) {
            const contentDiv = document.getElementById('responsesContent');

            try {
                const response = await axios.get(`/mitra/nilai-tryout/${examSlug}/response-data/${encodeURIComponent(category)}`);
                
                if (!response.data.success) {
                    throw new Error('Gagal memuat data jawaban');
                }

                const { questions, responses } = response.data.data;

                if (questions.length === 0) {
                    contentDiv.innerHTML = `
                        <div class="no-data">
                            <div class="no-data-icon">❌</div>
                            <div>Tidak ada soal ditemukan untuk mata pelajaran ini</div>
                        </div>
                    `;
                    return;
                }

                contentDiv.innerHTML = `
                    <div class="table-wrapper">
                        <table>
                            <thead>
                                <tr>
                                    <th>Nama Peserta</th>
                                   ${questions.map((_, index) => `<th>Soal ${index + 1}</th>`).join('')}
                                    <th>Total Benar</th>
                                </tr>
                            </thead>
                            <tbody>
                                ${responses.map(user => `
                                    <tr>
                                        <td><strong>${user.name}</strong></td>
                                        ${user.answers.map(answer => `
                                            <td class="${answer ? 'correct' : 'incorrect'}">
                                                ${answer ? 1 : 0}
                                            </td>
                                        `).join('')}
                                        <td><strong>${user.total_correct}</strong></td>
                                    </tr>
                                `).join('')}
                            </tbody>
                        </table>
                    </div>
                `;
            } catch (error) {
                console.error('Error:', error);
                contentDiv.innerHTML = `
                    <div class="no-data">
                        <div class="no-data-icon">❌</div>
                        <div>Error: ${error.response?.data?.message || error.message}</div>
                    </div>
                `;
            }
        }
    </script>
    @endsection
    

