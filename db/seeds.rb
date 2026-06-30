# Bruno Coup de Feu
# Source : Base_de_connaissances_Bruno_Coup_de_Feu.md (nouveau modele tarifaire)
# + fiches pratiques de l'ancienne base reformulees pour rester coherentes.
# La base de connaissances est REMPLACEE integralement a chaque execution
# (delete_all puis create) : relancer ce fichier remet la base a l'etat voulu,
# sans doublon.

# --- Compte de demo (connexion obligatoire pour acceder a Bruno) ---
puts "Compte de demo..."
demo = User.find_or_create_by!(email: "demo@coupdefeu.app") do |u|
  u.password = "password"
  u.password_confirmation = "password"
end
puts "  -> #{demo.email} / mot de passe : password"

# --- Base de connaissances de Bruno (contenu factuel uniquement) ---
puts "Base de connaissances..."
fiches = [
  # TARIFS ET ABONNEMENT (nouveau modele)
  { category: "tarifs", title: "Offre de bienvenue", source: "FAQ tarifs",
    content: "Pour un établissement qui souscrit un abonnement pour la première fois, le premier mois est offert. Pendant ce mois gratuit, tu disposes de 3 alertes gratuites pour tester Coup de Feu en conditions réelles. À la fin du mois d'essai, l'abonnement devient payant, sauf si tu résilies avant la fin de la période d'essai." },
  { category: "tarifs", title: "Prix de l'abonnement", source: "FAQ tarifs",
    content: "L'abonnement de base est à 39 € TTC par mois. Il comprend 3 alertes de renfort par mois. Il est sans engagement et résiliable à tout moment." },
  { category: "tarifs", title: "Alertes supplémentaires", source: "FAQ tarifs",
    content: "Une fois tes 3 alertes incluses utilisées, tu peux soit acheter une alerte supplémentaire pour 12 €, soit passer à une formule supérieure." },
  { category: "tarifs", title: "Qui paie ?", source: "FAQ tarifs",
    content: "Seuls les établissements paient l'abonnement. Les renforts ne paient jamais rien." },

  # POSITIONNEMENT
  { category: "positionnement", title: "Pas de commission sur les missions", source: "FAQ positionnement",
    content: "Contrairement à de nombreuses plateformes, Coup de Feu ne prend aucune commission sur les missions. L'établissement paie uniquement un abonnement clair et prévisible." },

  # ALERTES
  { category: "alertes", title: "Qu'est-ce qu'une alerte ?", source: "FAQ fonctionnement",
    content: "Une alerte est une demande urgente envoyée aux professionnels qui correspondent aux critères recherchés. Les premiers profils peuvent arriver rapidement, mais aucun délai précis ni aucun résultat n'est garanti." },

  # RENFORTS
  { category: "renforts", title: "Inscription et statut des renforts", source: "FAQ renforts",
    content: "L'inscription comme renfort est gratuite et les renforts ne paient jamais. Coup de Feu n'est pas l'employeur : la relation de travail se conclut directement entre l'établissement et le professionnel." },

  # DONNEES ET SECURITE
  { category: "données & sécurité", title: "Données et sécurité", source: "FAQ sécurité",
    content: "Tes données servent uniquement au fonctionnement de la plateforme et ne sont jamais revendues. Coup de Feu respecte le RGPD et les paiements sont sécurisés. Bruno ne demande jamais de coordonnées bancaires ni de mot de passe." },

  # INSCRIPTION & PROFILS (reintegre)
  { category: "inscription & profils", title: "Créer un compte établissement", source: "FAQ inscription",
    content: "Inscris ton établissement en quelques minutes : nom, type (restaurant, hôtel, événement), adresse et contact. Tu choisis ensuite ton abonnement au moment de poster ta première demande." },
  { category: "inscription & profils", title: "Créer un profil renfort", source: "FAQ inscription",
    content: "Crée ton profil renfort gratuitement : poste recherché (serveur, cuisinier, plongeur, extra), expérience, zone de déplacement et disponibilités. Un profil complet et clair reçoit plus de missions, donc soigne-le." },
  { category: "inscription & profils", title: "Compléter et vérifier son profil", source: "FAQ profils",
    content: "Plus ton profil est complet, plus tu inspires confiance : photo, expériences passées, et idéalement quelques avis de missions réalisées. Les établissements regardent ces éléments avant de confirmer un renfort." },

  # FONCTIONNEMENT (reintegre, reformule sans promesse de delai)
  { category: "fonctionnement", title: "Mode urgent (jour même)", source: "FAQ fonctionnement",
    content: "En mode urgent, tu publies une alerte pour le jour même : elle part immédiatement aux renforts disponibles et proches. Les premiers profils peuvent arriver vite, mais aucun délai n'est garanti." },
  { category: "fonctionnement", title: "Mode planifié (à l'avance)", source: "FAQ fonctionnement",
    content: "Tu peux aussi anticiper : publie ta demande plusieurs jours à l'avance pour un service chargé, un événement ou un remplacement prévu. Les renforts postulent et tu confirmes ton choix tranquillement." },
  { category: "fonctionnement", title: "Couverture locale et régionale", source: "FAQ fonctionnement",
    content: "On cible d'abord les renforts les plus proches de toi, puis on élargit à la région si besoin pour les profils plus rares. Tu vois la zone de déplacement de chaque renfort sur son profil." },
  { category: "fonctionnement", title: "Poster une demande de renfort", source: "FAQ fonctionnement",
    content: "Pour poster une demande : choisis le poste, la date et l'horaire, le tarif que tu proposes et le mode (urgent ou planifié). Une fois publiée, elle est envoyée aux renforts correspondants et tu reçois les réponses dans ton espace." },
  { category: "fonctionnement", title: "Accepter une mission (côté renfort)", source: "FAQ fonctionnement",
    content: "Quand une mission correspond à ton profil et ta zone, tu reçois une notification. Tu consultes les détails (lieu, horaire, tarif) et tu acceptes en un clic. L'établissement est prévenu aussitôt et confirme." },

  # REGLES & ANNULATION (reintegre ; no-show recentre sur le renfort)
  { category: "règles & annulation", title: "Annuler une demande ou une mission", source: "règlement du service",
    content: "Tu peux annuler tant que la mission n'est pas confirmée des deux côtés. Une fois confirmée, préviens le plus tôt possible par respect pour l'autre partie." },
  { category: "règles & annulation", title: "Absence ou no-show (côté renfort)", source: "règlement du service",
    content: "Un renfort qui ne se présente pas à une mission confirmée, ou qui ne prévient pas dans des délais raisonnables, risque de ne plus être sélectionné par les établissements. Ce risque augmente si cela se répète : les établissements privilégient les profils fiables. Si tu ne peux pas assurer une mission, préviens toujours le plus tôt possible." },

  # PAIEMENT (reintegre)
  { category: "paiement", title: "Comment le renfort est payé", source: "FAQ paiement",
    content: "Le tarif de la mission est celui fixé par l'établissement et accepté par le renfort, sans commission. Le paiement se règle entre l'établissement et le renfort selon les modalités convenues, et Coup de Feu ne prélève rien sur ce montant." },

  # SUPPORT (reintegre)
  { category: "support", title: "Contacter le support", source: "FAQ support",
    content: "Une question, un souci sur une mission ou un paiement ? Écris au support depuis ton espace ou à aide@coupdefeu.app. On répond vite, surtout en plein coup de feu." }
]

# Remplacement integral : on vide puis on recree.
KnowledgeItem.delete_all
fiches.each { |attrs| KnowledgeItem.create!(attrs) }

puts "#{KnowledgeItem.count} fiches en base. Bruno est pret."
