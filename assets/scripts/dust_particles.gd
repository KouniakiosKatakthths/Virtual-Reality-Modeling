extends Node3D
class_name DustParticles

# Get ref to the particle system
@onready var particle_system: GPUParticles3D = $GPUParticles3D;

func emmit():
	particle_system.restart();
	particle_system.emitting = true;
