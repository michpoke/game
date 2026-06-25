# notes_generator.gd
extends Node
class_name NotesGenerator

const USERNAME_POOL = [
	"starlightdrifter", "void-walker99", "lethologica", 
	# ... your worldbuilding usernames
]

static func generate_notes(post: PostData) -> Array[String]:
	var rng = RandomNumberGenerator.new()
	rng.seed = hash(post.post_id)
	var notes: Array[String] = []
	var pool_copy = USERNAME_POOL.duplicate()
	pool_copy.shuffle_seeded(rng)
	for i in range(min(post.notes_count, pool_copy.size())):
		notes.append(pool_copy[i])
	return notes
