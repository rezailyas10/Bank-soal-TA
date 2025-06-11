@extends('layouts.mitra')

@section('title')
  Mitra Dashboard
@endsection

@section('content')
<div
class="section-content section-dashboard-home"
data-aos="fade-up"
>
<div class="container-fluid">
  <div class="dashboard-heading">
    <h2 class="dashboard-title">Mitra Dashboard</h2>
    <p class="dashboard-subtitle">
      This is Dashboard Partner Panel
    </p>
  </div>
  <div class="dashboard-content">
    <div class="row">
      <div class="col-md-4">
        <div class="card mb-2">
          <div class="card-body">
            <div class="dashboard-card-title">
              Customer
            </div>
            <div class="dashboard-card-subtitle">
             \
            </div>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card mb-2">
          <div class="card-body">
            <div class="dashboard-card-title">
              Revenue
            </div>
            <div class="dashboard-card-subtitle">
              $ 
            </div>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card mb-2">
          <div class="card-body">
            <div class="dashboard-card-title">
              Transaction
            </div>
            <div class="dashboard-card-subtitle">
             g
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="row mt-3">
      
    </div>
  </div>
</div>
</div>

@endsection