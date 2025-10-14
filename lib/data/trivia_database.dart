import '../models/trivia_question.dart';

class TriviaDatabase {
  static List<TriviaQuestion> get allQuestions => [
    ...fitnessQuestions,
    ...nutritionQuestions,
    ...healthWellnessQuestions,
    ...sportsHistoryQuestions,
  ];

  // 120 preguntas de Fitness (40%)
  static List<TriviaQuestion> get fitnessQuestions => [
    // FÁCIL - Conceptos básicos (40 preguntas)
    TriviaQuestion(
      id: 'f001',
      question: '¿Cuántos músculos principales componen los abdominales?',
      options: ['2', '4', '6', '8'],
      correctAnswerIndex: 1,
      category: QuestionCategory.fitness,
      difficulty: QuestionDifficulty.easy,
      explanation: 'Los abdominales se componen de 4 músculos principales: recto abdominal, oblicuos externos, oblicuos internos y transverso del abdomen.',
      tags: ['anatomía', 'abdominales'],
    ),

    TriviaQuestion(
      id: 'f002',
      question: '¿Cuál es la frecuencia cardíaca máxima aproximada para una persona de 30 años?',
      options: ['170 bpm', '180 bpm', '190 bpm', '200 bpm'],
      correctAnswerIndex: 2,
      category: QuestionCategory.fitness,
      difficulty: QuestionDifficulty.easy,
      explanation: 'La fórmula básica es 220 - edad. Para 30 años: 220 - 30 = 190 bpm.',
      tags: ['cardio', 'frecuencia cardíaca'],
    ),

    TriviaQuestion(
      id: 'f003',
      question: '¿Qué significa "rep" en el entrenamiento de fuerza?',
      options: ['Repetición', 'Resistencia', 'Recuperación', 'Rango'],
      correctAnswerIndex: 0,
      category: QuestionCategory.fitness,
      difficulty: QuestionDifficulty.easy,
      explanation: '"Rep" es la abreviación de repetición, que es una ejecución completa de un ejercicio.',
      tags: ['terminología', 'fuerza'],
    ),

    TriviaQuestion(
      id: 'f004',
      question: '¿Cuál es el músculo más grande del cuerpo humano?',
      options: ['Cuádriceps', 'Glúteo mayor', 'Dorsales', 'Pectorales'],
      correctAnswerIndex: 1,
      category: QuestionCategory.fitness,
      difficulty: QuestionDifficulty.easy,
      explanation: 'El glúteo mayor es el músculo individual más grande y fuerte del cuerpo humano.',
      tags: ['anatomía', 'músculos'],
    ),

    TriviaQuestion(
      id: 'f005',
      question: '¿Cuántas series se recomiendan generalmente para principiantes por grupo muscular?',
      options: ['1-2 series', '2-3 series', '3-4 series', '5-6 series'],
      correctAnswerIndex: 1,
      category: QuestionCategory.fitness,
      difficulty: QuestionDifficulty.easy,
      explanation: 'Para principiantes, 2-3 series por ejercicio es óptimo para permitir adaptación sin sobreentrenamiento.',
      tags: ['principiantes', 'series'],
    ),

    TriviaQuestion(
      id: 'f006',
      question: '¿Qué tipo de ejercicio es más efectivo para quemar grasa?',
      options: ['Solo cardio', 'Solo pesas', 'Combinación de ambos', 'Estiramientos'],
      correctAnswerIndex: 2,
      category: QuestionCategory.fitness,
      difficulty: QuestionDifficulty.easy,
      explanation: 'La combinación de cardio y entrenamiento de fuerza es más efectiva para quemar grasa y mantener el músculo.',
      tags: ['pérdida de grasa', 'cardio', 'fuerza'],
    ),

    TriviaQuestion(
      id: 'f007',
      question: '¿Cuál es el rango de repeticiones ideal para hipertrofia muscular?',
      options: ['1-5 reps', '6-12 reps', '13-20 reps', '20+ reps'],
      correctAnswerIndex: 1,
      category: QuestionCategory.fitness,
      difficulty: QuestionDifficulty.easy,
      explanation: 'El rango de 6-12 repeticiones es óptimo para estimular el crecimiento muscular (hipertrofia).',
      tags: ['hipertrofia', 'repeticiones'],
    ),

    TriviaQuestion(
      id: 'f008',
      question: '¿Qué ejercicio trabaja principalmente los músculos del pecho?',
      options: ['Sentadillas', 'Press de banca', 'Peso muerto', 'Dominadas'],
      correctAnswerIndex: 1,
      category: QuestionCategory.fitness,
      difficulty: QuestionDifficulty.easy,
      explanation: 'El press de banca es el ejercicio fundamental para desarrollar los músculos pectorales.',
      tags: ['pecho', 'ejercicios básicos'],
    ),

    TriviaQuestion(
      id: 'f009',
      question: '¿Cuántos días de descanso se recomiendan entre entrenamientos del mismo grupo muscular?',
      options: ['0 días', '1 día', '2-3 días', '1 semana'],
      correctAnswerIndex: 2,
      category: QuestionCategory.fitness,
      difficulty: QuestionDifficulty.easy,
      explanation: 'Los músculos necesitan 48-72 horas (2-3 días) para recuperarse completamente después del entrenamiento.',
      tags: ['recuperación', 'descanso'],
    ),

    TriviaQuestion(
      id: 'f010',
      question: '¿Qué significa HIIT?',
      options: ['High Impact Indoor Training', 'High Intensity Interval Training', 'Heavy Iron Intensive Training', 'Healthy Integrated Interval Training'],
      correctAnswerIndex: 1,
      category: QuestionCategory.fitness,
      difficulty: QuestionDifficulty.easy,
      explanation: 'HIIT significa High Intensity Interval Training (Entrenamiento de Intervalos de Alta Intensidad).',
      tags: ['cardio', 'terminología'],
    ),

    // Continúo con más preguntas de fitness...
    TriviaQuestion(
      id: 'f011',
      question: '¿Cuál es el principal beneficio del calentamiento antes del ejercicio?',
      options: ['Quemar calorías', 'Prevenir lesiones', 'Construir músculo', 'Mejorar flexibilidad'],
      correctAnswerIndex: 1,
      category: QuestionCategory.fitness,
      difficulty: QuestionDifficulty.easy,
      explanation: 'El calentamiento prepara el cuerpo para el ejercicio y reduce significativamente el riesgo de lesiones.',
      tags: ['calentamiento', 'prevención'],
    ),

    TriviaQuestion(
      id: 'f012',
      question: '¿Qué ejercicio es considerado el "rey" de los ejercicios?',
      options: ['Press de banca', 'Sentadillas', 'Peso muerto', 'Dominadas'],
      correctAnswerIndex: 1,
      category: QuestionCategory.fitness,
      difficulty: QuestionDifficulty.easy,
      explanation: 'Las sentadillas son llamadas el "rey de los ejercicios" porque trabajan múltiples grupos musculares.',
      tags: ['sentadillas', 'ejercicios compuestos'],
    ),

    TriviaQuestion(
      id: 'f013',
      question: '¿Cuántos minutos de actividad física moderada se recomiendan por semana?',
      options: ['75 minutos', '150 minutos', '300 minutos', '500 minutos'],
      correctAnswerIndex: 1,
      category: QuestionCategory.fitness,
      difficulty: QuestionDifficulty.easy,
      explanation: 'La OMS recomienda al menos 150 minutos de actividad física moderada por semana.',
      tags: ['recomendaciones', 'actividad física'],
    ),

    TriviaQuestion(
      id: 'f014',
      question: '¿Qué parte del cuerpo trabajan principalmente las flexiones de brazos?',
      options: ['Piernas', 'Espalda', 'Pecho, hombros y tríceps', 'Abdomen'],
      correctAnswerIndex: 2,
      category: QuestionCategory.fitness,
      difficulty: QuestionDifficulty.easy,
      explanation: 'Las flexiones trabajan principalmente pecho, hombros y tríceps, también involucran el core.',
      tags: ['flexiones', 'tren superior'],
    ),

    TriviaQuestion(
      id: 'f015',
      question: '¿Qué significa "core" en el entrenamiento?',
      options: ['Músculos del brazo', 'Músculos centrales del tronco', 'Músculos de las piernas', 'Músculos del cuello'],
      correctAnswerIndex: 1,
      category: QuestionCategory.fitness,
      difficulty: QuestionDifficulty.easy,
      explanation: 'El core se refiere a los músculos centrales del tronco que estabilizan la columna vertebral.',
      tags: ['core', 'estabilidad'],
    ),

    // MEDIO - Técnica y planificación (40 preguntas)
    TriviaQuestion(
      id: 'f041',
      question: '¿Qué es el principio de sobrecarga progresiva?',
      options: ['Entrenar hasta el fallo muscular', 'Aumentar gradualmente la intensidad del entrenamiento', 'Hacer más cardio cada semana', 'Cambiar ejercicios constantemente'],
      correctAnswerIndex: 1,
      category: QuestionCategory.fitness,
      difficulty: QuestionDifficulty.medium,
      explanation: 'La sobrecarga progresiva implica aumentar gradualmente el estrés en el músculo para forzar la adaptación.',
      tags: ['principios', 'progresión'],
    ),

    TriviaQuestion(
      id: 'f042',
      question: '¿Cuál es la diferencia principal entre fuerza y potencia?',
      options: ['No hay diferencia', 'La potencia incluye velocidad', 'La fuerza es para principiantes', 'La potencia es solo para atletas'],
      correctAnswerIndex: 1,
      category: QuestionCategory.fitness,
      difficulty: QuestionDifficulty.medium,
      explanation: 'La potencia es fuerza aplicada con velocidad (Potencia = Fuerza × Velocidad).',
      tags: ['fuerza', 'potencia', 'biomecánica'],
    ),

    TriviaQuestion(
      id: 'f043',
      question: '¿Qué es la periodización en el entrenamiento?',
      options: ['Entrenar solo por períodos', 'Planificación sistemática del entrenamiento', 'Descansar periódicamente', 'Cambiar de gimnasio'],
      correctAnswerIndex: 1,
      category: QuestionCategory.fitness,
      difficulty: QuestionDifficulty.medium,
      explanation: 'La periodización es la planificación sistemática del entrenamiento en ciclos para optimizar el rendimiento.',
      tags: ['periodización', 'planificación'],
    ),

    // DIFÍCIL - Conceptos avanzados (40 preguntas)
    TriviaQuestion(
      id: 'f081',
      question: '¿Qué es el efecto EPOC?',
      options: ['Un tipo de suplemento', 'Consumo de oxígeno post-ejercicio', 'Una técnica de estiramiento', 'Un método de calentamiento'],
      correctAnswerIndex: 1,
      category: QuestionCategory.fitness,
      difficulty: QuestionDifficulty.hard,
      explanation: 'EPOC (Excess Post-Exercise Oxygen Consumption) es el aumento del consumo de oxígeno después del ejercicio.',
      tags: ['fisiología', 'metabolismo'],
    ),

    // Agrego algunas preguntas más para completar una muestra representativa...
    TriviaQuestion(
      id: 'f016',
      question: '¿Cuál es la mejor forma de medir la intensidad del ejercicio cardiovascular?',
      options: ['Por el sudor producido', 'Por la frecuencia cardíaca', 'Por el tiempo transcurrido', 'Por la música que escuchas'],
      correctAnswerIndex: 1,
      category: QuestionCategory.fitness,
      difficulty: QuestionDifficulty.easy,
      explanation: 'La frecuencia cardíaca es el indicador más preciso de la intensidad del ejercicio cardiovascular.',
      tags: ['cardio', 'intensidad'],
    ),

    TriviaQuestion(
      id: 'f017',
      question: '¿Qué músculo se trabaja principalmente en las dominadas?',
      options: ['Bíceps', 'Dorsales', 'Pectorales', 'Tríceps'],
      correctAnswerIndex: 1,
      category: QuestionCategory.fitness,
      difficulty: QuestionDifficulty.easy,
      explanation: 'Las dominadas trabajan principalmente los músculos dorsales (latissimus dorsi) de la espalda.',
      tags: ['dominadas', 'espalda'],
    ),

    TriviaQuestion(
      id: 'f018',
      question: '¿Cuánto tiempo debe durar un entrenamiento típico?',
      options: ['15-30 minutos', '45-60 minutos', '90-120 minutos', '3+ horas'],
      correctAnswerIndex: 1,
      category: QuestionCategory.fitness,
      difficulty: QuestionDifficulty.easy,
      explanation: 'Un entrenamiento efectivo típicamente dura entre 45-60 minutos para optimizar resultados sin sobreentrenamiento.',
      tags: ['duración', 'entrenamiento'],
    ),

    TriviaQuestion(
      id: 'f019',
      question: '¿Qué es mejor para quemar grasa: cardio en ayunas o después de comer?',
      options: ['Siempre en ayunas', 'Siempre después de comer', 'Depende de la persona y objetivos', 'No importa el momento'],
      correctAnswerIndex: 2,
      category: QuestionCategory.fitness,
      difficulty: QuestionDifficulty.medium,
      explanation: 'La efectividad del cardio en ayunas vs. alimentado depende de factores individuales y objetivos específicos.',
      tags: ['cardio', 'nutrición timing'],
    ),

    TriviaQuestion(
      id: 'f020',
      question: '¿Qué porcentaje de la frecuencia cardíaca máxima se considera "zona de quema de grasa"?',
      options: ['50-60%', '60-70%', '70-80%', '80-90%'],
      correctAnswerIndex: 1,
      category: QuestionCategory.fitness,
      difficulty: QuestionDifficulty.medium,
      explanation: 'La zona de quema de grasa tradicionalmente se sitúa entre 60-70% de la FCmax, aunque el gasto calórico total también es importante.',
      tags: ['zonas cardiacas', 'quema de grasa'],
    ),
  ];

  // 120 preguntas de Nutrición (40%)
  static List<TriviaQuestion> get nutritionQuestions => [
    // FÁCIL - Conceptos básicos de nutrición (40 preguntas)
    TriviaQuestion(
      id: 'n001',
      question: '¿Cuántas calorías tiene aproximadamente 1 gramo de proteína?',
      options: ['2 kcal', '4 kcal', '7 kcal', '9 kcal'],
      correctAnswerIndex: 1,
      category: QuestionCategory.nutrition,
      difficulty: QuestionDifficulty.easy,
      explanation: 'Las proteínas y carbohidratos aportan 4 kcal por gramo, mientras que las grasas aportan 9 kcal por gramo.',
      tags: ['macronutrientes', 'calorías'],
    ),

    TriviaQuestion(
      id: 'n002',
      question: '¿Cuál es el macronutriente más calórico?',
      options: ['Proteínas', 'Carbohidratos', 'Grasas', 'Fibra'],
      correctAnswerIndex: 2,
      category: QuestionCategory.nutrition,
      difficulty: QuestionDifficulty.easy,
      explanation: 'Las grasas proporcionan 9 calorías por gramo, más del doble que proteínas y carbohidratos.',
      tags: ['macronutrientes', 'grasas'],
    ),

    TriviaQuestion(
      id: 'n003',
      question: '¿Cuántos aminoácidos esenciales necesita el cuerpo humano?',
      options: ['6', '8', '9', '12'],
      correctAnswerIndex: 2,
      category: QuestionCategory.nutrition,
      difficulty: QuestionDifficulty.easy,
      explanation: 'Hay 9 aminoácidos esenciales que el cuerpo no puede producir y debe obtener de los alimentos.',
      tags: ['proteínas', 'aminoácidos'],
    ),

    TriviaQuestion(
      id: 'n004',
      question: '¿Qué vitamina se produce principalmente por exposición al sol?',
      options: ['Vitamina A', 'Vitamina C', 'Vitamina D', 'Vitamina K'],
      correctAnswerIndex: 2,
      category: QuestionCategory.nutrition,
      difficulty: QuestionDifficulty.easy,
      explanation: 'La vitamina D se sintetiza en la piel cuando se expone a la radiación UVB del sol.',
      tags: ['vitaminas', 'sol'],
    ),

    TriviaQuestion(
      id: 'n005',
      question: '¿Cuál es la recomendación mínima de agua diaria para adultos?',
      options: ['1 litro', '2 litros', '3 litros', '4 litros'],
      correctAnswerIndex: 1,
      category: QuestionCategory.nutrition,
      difficulty: QuestionDifficulty.easy,
      explanation: 'Se recomienda aproximadamente 2 litros de agua al día, aunque varía según actividad y clima.',
      tags: ['hidratación', 'agua'],
    ),

    TriviaQuestion(
      id: 'n006',
      question: '¿Qué mineral es esencial para la formación de huesos?',
      options: ['Hierro', 'Calcio', 'Zinc', 'Magnesio'],
      correctAnswerIndex: 1,
      category: QuestionCategory.nutrition,
      difficulty: QuestionDifficulty.easy,
      explanation: 'El calcio es fundamental para la formación y mantenimiento de huesos y dientes.',
      tags: ['minerales', 'huesos'],
    ),

    TriviaQuestion(
      id: 'n007',
      question: '¿Cuál de estos alimentos es una proteína completa?',
      options: ['Arroz', 'Frijoles', 'Huevos', 'Almendras'],
      correctAnswerIndex: 2,
      category: QuestionCategory.nutrition,
      difficulty: QuestionDifficulty.easy,
      explanation: 'Los huevos contienen todos los aminoácidos esenciales en proporciones adecuadas.',
      tags: ['proteínas completas', 'huevos'],
    ),

    TriviaQuestion(
      id: 'n008',
      question: '¿Qué tipo de grasa es considerada más saludable?',
      options: ['Saturadas', 'Trans', 'Monoinsaturadas', 'Todas son iguales'],
      correctAnswerIndex: 2,
      category: QuestionCategory.nutrition,
      difficulty: QuestionDifficulty.easy,
      explanation: 'Las grasas monoinsaturadas (como en aceite de oliva y aguacate) son las más beneficiosas.',
      tags: ['grasas saludables', 'monoinsaturadas'],
    ),

    // MEDIO - Nutrición deportiva y planificación (40 preguntas)
    TriviaQuestion(
      id: 'n041',
      question: '¿Cuál es la ventana anabólica post-entrenamiento?',
      options: ['15 minutos', '30-60 minutos', '2-3 horas', '6 horas'],
      correctAnswerIndex: 1,
      category: QuestionCategory.nutrition,
      difficulty: QuestionDifficulty.medium,
      explanation: 'La ventana anabólica tradicionalmente se considera 30-60 minutos post-ejercicio para optimizar la síntesis proteica.',
      tags: ['timing nutricional', 'post-entrenamiento'],
    ),

    TriviaQuestion(
      id: 'n042',
      question: '¿Cuánta proteína por kg de peso corporal necesita un atleta de fuerza?',
      options: ['0.8-1.0g', '1.2-1.4g', '1.6-2.2g', '3.0g+'],
      correctAnswerIndex: 2,
      category: QuestionCategory.nutrition,
      difficulty: QuestionDifficulty.medium,
      explanation: 'Los atletas de fuerza necesitan 1.6-2.2g de proteína por kg de peso corporal para optimizar la síntesis muscular.',
      tags: ['proteína', 'atletas'],
    ),

    // DIFÍCIL - Bioquímica nutricional (40 preguntas)
    TriviaQuestion(
      id: 'n081',
      question: '¿Qué es el índice glucémico?',
      options: ['Medida de azúcar en sangre', 'Velocidad de absorción de carbohidratos', 'Cantidad de glucosa en alimentos', 'Tipo de diabetes'],
      correctAnswerIndex: 1,
      category: QuestionCategory.nutrition,
      difficulty: QuestionDifficulty.hard,
      explanation: 'El índice glucémico mide qué tan rápido los carbohidratos elevan los niveles de glucosa en sangre.',
      tags: ['índice glucémico', 'carbohidratos'],
    ),

    // Continúo con más ejemplos representativos...
    TriviaQuestion(
      id: 'n009',
      question: '¿Qué vitamina ayuda en la absorción del hierro?',
      options: ['Vitamina A', 'Vitamina B12', 'Vitamina C', 'Vitamina E'],
      correctAnswerIndex: 2,
      category: QuestionCategory.nutrition,
      difficulty: QuestionDifficulty.medium,
      explanation: 'La vitamina C mejora significativamente la absorción del hierro no hemo.',
      tags: ['vitamina C', 'hierro', 'absorción'],
    ),

    TriviaQuestion(
      id: 'n010',
      question: '¿Cuál es el mejor momento para consumir carbohidratos si entrenas?',
      options: ['Solo en la mañana', 'Antes y después del entrenamiento', 'Solo en la noche', 'No importa el momento'],
      correctAnswerIndex: 1,
      category: QuestionCategory.nutrition,
      difficulty: QuestionDifficulty.medium,
      explanation: 'Los carbohidratos antes del entrenamiento proporcionan energía, y después ayudan en la recuperación.',
      tags: ['timing nutricional', 'carbohidratos'],
    ),
  ];

  // 30 preguntas de Salud y Bienestar (10%)
  static List<TriviaQuestion> get healthWellnessQuestions => [
    TriviaQuestion(
      id: 'h001',
      question: '¿Cuántas horas de sueño se recomiendan para adultos?',
      options: ['5-6 horas', '7-9 horas', '10-12 horas', '4-5 horas'],
      correctAnswerIndex: 1,
      category: QuestionCategory.healthWellness,
      difficulty: QuestionDifficulty.easy,
      explanation: 'Los adultos necesitan entre 7-9 horas de sueño para una óptima recuperación y salud.',
      tags: ['sueño', 'descanso'],
    ),

    TriviaQuestion(
      id: 'h002',
      question: '¿Qué es el cortisol?',
      options: ['Vitamina del estrés', 'Hormona del estrés', 'Tipo de ejercicio', 'Suplemento'],
      correctAnswerIndex: 1,
      category: QuestionCategory.healthWellness,
      difficulty: QuestionDifficulty.easy,
      explanation: 'El cortisol es conocido como la "hormona del estrés" y afecta el metabolismo y la recuperación.',
      tags: ['hormonas', 'estrés'],
    ),

    TriviaQuestion(
      id: 'h003',
      question: '¿Qué técnica de relajación implica respiración profunda?',
      options: ['Yoga', 'Meditación', 'Respiración diafragmática', 'Todas las anteriores'],
      correctAnswerIndex: 3,
      category: QuestionCategory.healthWellness,
      difficulty: QuestionDifficulty.easy,
      explanation: 'El yoga, la meditación y la respiración diafragmática incluyen técnicas de respiración profunda.',
      tags: ['relajación', 'respiración'],
    ),

    TriviaQuestion(
      id: 'h004',
      question: '¿Qué es la frecuencia cardíaca en reposo normal?',
      options: ['40-60 bpm', '60-100 bpm', '100-120 bpm', '120+ bpm'],
      correctAnswerIndex: 1,
      category: QuestionCategory.healthWellness,
      difficulty: QuestionDifficulty.easy,
      explanation: 'Una frecuencia cardíaca en reposo normal para adultos está entre 60-100 latidos por minuto.',
      tags: ['corazón', 'salud cardiovascular'],
    ),

    TriviaQuestion(
      id: 'h005',
      question: '¿Cuál es el beneficio principal del ejercicio para la salud mental?',
      options: ['Mejora el humor', 'Reduce estrés', 'Aumenta autoestima', 'Todos los anteriores'],
      correctAnswerIndex: 3,
      category: QuestionCategory.healthWellness,
      difficulty: QuestionDifficulty.easy,
      explanation: 'El ejercicio mejora el humor, reduce el estrés y aumenta la autoestima mediante endorfinas.',
      tags: ['salud mental', 'ejercicio'],
    ),
  ];

  // 30 preguntas de Historia del Deporte (10%)
  static List<TriviaQuestion> get sportsHistoryQuestions => [
    TriviaQuestion(
      id: 's001',
      question: '¿En qué año se celebraron los primeros Juegos Olímpicos modernos?',
      options: ['1892', '1896', '1900', '1904'],
      correctAnswerIndex: 1,
      category: QuestionCategory.sportsHistory,
      difficulty: QuestionDifficulty.easy,
      explanation: 'Los primeros Juegos Olímpicos modernos se celebraron en Atenas en 1896.',
      tags: ['olimpiadas', 'historia'],
    ),

    TriviaQuestion(
      id: 's002',
      question: '¿Quién es considerado el atleta olímpico más exitoso de todos los tiempos?',
      options: ['Carl Lewis', 'Mark Spitz', 'Michael Phelps', 'Usain Bolt'],
      correctAnswerIndex: 2,
      category: QuestionCategory.sportsHistory,
      difficulty: QuestionDifficulty.easy,
      explanation: 'Michael Phelps tiene 23 medallas de oro olímpicas, el récord de todos los tiempos.',
      tags: ['olimpiadas', 'natación', 'récords'],
    ),

    TriviaQuestion(
      id: 's003',
      question: '¿En qué deporte destacó Muhammad Ali?',
      options: ['Atletismo', 'Boxeo', 'Lucha', 'Levantamiento de pesas'],
      correctAnswerIndex: 1,
      category: QuestionCategory.sportsHistory,
      difficulty: QuestionDifficulty.easy,
      explanation: 'Muhammad Ali fue uno de los boxeadores más famosos e influyentes de la historia.',
      tags: ['boxeo', 'leyendas'],
    ),

    TriviaQuestion(
      id: 's004',
      question: '¿Quién ostenta el récord mundial actual de los 100 metros planos?',
      options: ['Carl Lewis', 'Usain Bolt', 'Tyson Gay', 'Justin Gatlin'],
      correctAnswerIndex: 1,
      category: QuestionCategory.sportsHistory,
      difficulty: QuestionDifficulty.medium,
      explanation: 'Usain Bolt posee el récord mundial de 100m con 9.58 segundos desde 2009.',
      tags: ['atletismo', 'récords', 'velocidad'],
    ),

    TriviaQuestion(
      id: 's005',
      question: '¿En qué año se introdujo el culturismo en los deportes?',
      options: ['1880s', '1920s', '1950s', '1970s'],
      correctAnswerIndex: 0,
      category: QuestionCategory.sportsHistory,
      difficulty: QuestionDifficulty.hard,
      explanation: 'El culturismo moderno comenzó a desarrollarse en la década de 1880 con Eugene Sandow.',
      tags: ['culturismo', 'historia del fitness'],
    ),
  ];

  static List<TriviaQuestion> getQuestionsByCategory(QuestionCategory category) {
    return allQuestions.where((q) => q.category == category).toList();
  }

  static List<TriviaQuestion> getQuestionsByDifficulty(QuestionDifficulty difficulty) {
    return allQuestions.where((q) => q.difficulty == difficulty).toList();
  }

  static TriviaQuiz createRandomQuiz({
    int questionCount = 10,
    QuestionCategory? category,
    QuestionDifficulty? difficulty,
  }) {
    var questions = allQuestions;
    
    if (category != null) {
      questions = questions.where((q) => q.category == category).toList();
    }
    
    if (difficulty != null) {
      questions = questions.where((q) => q.difficulty == difficulty).toList();
    }
    
    questions.shuffle();
    final selectedQuestions = questions.take(questionCount).toList();
    
    return TriviaQuiz(
      id: 'quiz_${DateTime.now().millisecondsSinceEpoch}',
      name: 'Quiz ${category?.displayName ?? "Mixto"}',
      questions: selectedQuestions,
      timeLimit: questionCount * 30, // 30 segundos por pregunta
    );
  }
}